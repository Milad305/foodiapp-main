// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:salamatiman/getx/blog/blog-getter.dart';
import 'package:salamatiman/model/blog/post_by_category_model.dart';
import 'package:salamatiman/utils/constants.dart';

import '../../service/blog/post-single.dart';
import 'post_tile.dart';

class BlogCategoryPosts extends GetView<PostGetter> {
  final PostByCategoryModel category;

  BlogCategoryPosts({Key? key, required this.category}) : super(key: key) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getPostBytCategory(cid: category.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: GlobalKey(debugLabel: "blog_category_posts"),
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: Constants.primaryColor,
        surfaceTintColor: Constants.primaryColor,
      ),
      body: Obx(() {
        final posts = controller.postListDataCategory;
        if (controller.loading.value) {
          return Center(
            child: SpinKitThreeBounce(
              color: Colors.black45,
              size: 17.sp,
            ),
          );
        }
        return SingleChildScrollView(
          child: Column(
            children: posts.map((element) {
              final post = element;
              final index = posts.indexOf(element);
              if (index == 0) {
                return GestureDetector(
                  onTap: () {
                    Get.to(() => PostSingle(
                          postID: post["id"],
                        ));
                  },
                  child: Container(
                    width: double.infinity,
                    height: Get.width * 0.60,
                    margin: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                    ),
                    alignment: Alignment.center,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(7),
                      child: Stack(
                        children: [
                          CachedNetworkImage(
                            width: double.infinity,
                            height: double.infinity,
                            imageUrl: "${post["preview"]}",
                            fit: BoxFit.fill,
                            placeholder: (context, url) => Image.asset(
                              "assets/images/placeholder.png",
                              fit: BoxFit.fill,
                            ),
                            errorWidget: (context, url, error) => Image.asset(
                              "assets/images/placeholder.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                          Positioned(
                            top: 0,
                            bottom: 0,
                            right: 0,
                            left: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.transparent,
                                    Constants.secondaryColor
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            left: 0,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                post["title"].toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w700),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              final isLast =
                  controller.postListDataCategory.length - 1 == index;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: PostTile(
                          post: Articles.fromJson(post), isLast: isLast),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        );
      }),
    );
  }

  Future<void> _onRefresh() async {
    int currentPage = controller.postListCategory[0]["current_page"];
    int total = controller.postListCategory[0]["total"];
    int to = controller.postListCategory[0]["to"];
    if (total > to) {
      await controller.getBlogArticleMore(froPage: currentPage + 1);
    }
  }
}
