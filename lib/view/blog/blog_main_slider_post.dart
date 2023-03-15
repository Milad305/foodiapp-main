import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../getx/blog/blog-getter.dart';
import '../../service/blog/post-single.dart';
import '../../utils/constants.dart';

class BlogMainSliderPost extends GetView<PostGetter> {
  final posts;
  PageController pageController = PageController(initialPage: 0);
  BlogMainSliderPost({Key? key, required this.posts}) : super(key: key) {
    Get.lazyPut(() => PostGetter());
    //controller.sliderPage(0);
  }

  @override
  Widget build(BuildContext context) {
    // if (posts[0].isNotEmpty) {
    //   final listPosts = posts[0]["data"];
    //   if (listPosts.isNotEmpty) {
    //     controller.timerSlider = Timer.periodic(
    //       Duration(seconds: 3),
    //       (Timer t) {
    //         if ((listPosts.length) - 1 > controller.sliderPage.value) {
    //           print("add ${controller.sliderPage.value}");
    //           controller.sliderPage.value =
    //               int.parse(controller.sliderPage.value.toString()) + 1;
    //           try {
    //             pageController.animateToPage(
    //               controller.sliderPage.value,
    //               duration: Duration(milliseconds: 350),
    //               curve: Curves.easeIn,
    //             );
    //           } catch (e) {
    //             if (kDebugMode) {
    //               print(e);
    //             }
    //           }
    //         } else {
    //           try {
    //             pageController.animateToPage(
    //               0,
    //               duration: Duration(milliseconds: 350),
    //               curve: Curves.easeIn,
    //             );
    //           } catch (e) {
    //             if (kDebugMode) {
    //               print(e);
    //             }
    //           }
    //           controller.sliderPage(0);
    //         }
    //       },
    //     );
    //   }
    // }

    if (posts[0].isEmpty) {
      return Container();
    }
    final listPosts = posts[0];
    return Obx(() {
      final sliderPage = controller.sliderPage.value;
      return ClipRRect(
        borderRadius: BorderRadius.circular(7),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: Get.width / 1.9,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: PageView.builder(
                  controller: pageController,
                  itemCount: listPosts.length,
                  onPageChanged: (val) {
                    controller.sliderPage(int.parse(val.toString()));
                  },
                  itemBuilder: (context, index) {
                    final post = listPosts[index];
                    return GestureDetector(
                      onTap: () => Get.to(() => PostSingle(
                            postID: post["id"],
                          )),
                      child: SizedBox(
                        height: double.infinity,
                        width: double.infinity,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              height: double.infinity,
                              child: CachedNetworkImage(
                                imageUrl: "${post["preview"]}",
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Image.asset(
                                  "assets/images/placeholder.png",
                                  fit: BoxFit.fill,
                                ),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                  "assets/images/placeholder.png",
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                colors: 
                                  Constants.profiileBg,
                                  
                                
                                end: Alignment.topCenter,
                                begin: Alignment.bottomCenter,
                              )),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 7, right: 7, bottom: 5, top: 40),
                                child: Text(
                                  "${post["title"]}",
                                  style: TextStyle(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 30,
              alignment: Alignment.center,
              child: Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: listPosts.map<Widget>((item) {
                  final index = listPosts.indexOf(item);
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    width: sliderPage == index ? 8 : 5,
                    height: sliderPage == index ? 8 : 5,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      color: sliderPage == index
                          ? Constants.secondaryColor
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  );
                }).toList(),
              ),
            )
          ],
        ),
      );
    });
  }
}
