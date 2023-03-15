import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:salamatiman/getx/blog/blog-getter.dart';
import 'package:salamatiman/utils/constants.dart';

import 'blog_main_search.dart';
import 'blog_main_slider_post.dart';
import 'category_post_slider.dart';

class BlogMain extends GetView<PostGetter> {
  BlogMain({Key? key}) : super(key: key) {
    Get.put(PostGetter());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (controller.postList.isEmpty) {
        await controller.getBlogArticle();
        await controller.gePostsBytCategory();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: GlobalKey(),
      appBar: AppBar(
        title: Text(
          "مقالات",
          style: TextStyle(
            fontSize: 23.sp,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
        toolbarHeight: 70,
        centerTitle: true,
        backgroundColor: Constants.primaryColor,
        surfaceTintColor: Constants.primaryColor,
      ),
      body: SafeArea(
        child: Obx(() {
          return controller.loading.value
              ? Center(
                  child: SpinKitThreeBounce(
                    color: Colors.black45,
                    size: 17,
                  ),
                )
              : Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const BlogMainSearch(),
                        const SizedBox(height: 13),
                        if (controller.postList.isNotEmpty) ...[
                          BlogMainSliderPost(posts: controller.postList),
                        ],
                        if (controller.postByCategory.isNotEmpty) ...[
                          Column(
                            children: controller.postByCategory
                                .map<Widget>((element) {
                              final category = element;
                              if (category.parent == 0) {
                                return CategoryPostSlider(
                                    category: category,
                                    categorys: controller.postByCategory);
                              }
                              return Container();
                            }).toList(),
                          )
                        ],
                      ],
                    ),
                  ),
                );
        }),
      ),
    );
  }

  Future<void> _onRefresh() async {
    await controller.getBlogArticle();
    await controller.gePostsBytCategory();
  }

  Widget PostTile({required post, required isLast}) {
    return Column(
      children: [
        ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(9),
            child: Image.network("${post["preview"]}",
                width: 70, height: 70, fit: BoxFit.fill),
          ),
          title: Text(
            post["title"],
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 18.sp),
          ),
          subtitle: Text(
            post["updated_at"] == null
                ? ""
                : post["updated_at"]
                    .toString()
                    .substring(0, 10)
                    .toPersianDate(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 17, color: Colors.grey),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios_rounded,
            size: 16,
          ),
        ),
        if (isLast == false) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Divider(
              height: 1.5,
            ),
          )
        ]
      ],
    );
  }
}
