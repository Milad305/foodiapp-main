import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/blog/post_by_category_model.dart';
import 'category_post_slider.dart';
import 'post_tile.dart';

class BlogCategoryChild extends StatelessWidget {
  final PostByCategoryModel category;
  final List<PostByCategoryModel> childs;
  const BlogCategoryChild(
      {Key? key, required this.category, required this.childs})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Container(
                //   width: double.infinity,
                //   height: Get.width * 0.70,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(10),
                //   ),
                //   child: ClipRRect(
                //     borderRadius: BorderRadius.circular(10),
                //     child: CachedNetworkImage(
                //       imageUrl: img.toString(),
                //       fit: BoxFit.cover,
                //       placeholder: (context, url) => Image.asset(
                //         "assets/images/placeholder.png",
                //         fit: BoxFit.fill,
                //       ),
                //       errorWidget: (context, url, error) => Image.asset(
                //         "assets/images/placeholder.png",
                //         fit: BoxFit.fill,
                //       ),
                //     ),
                //   ),
                // ),
                SizedBox(height: 20.sp),
                Column(
                  children: childs
                      .map(
                          (e) => CategoryPostSlider(category: e, categorys: []))
                      .toList(),
                ),
                Column(
                  children: category.articles!
                      .map(
                        (Articles e) => Container(
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: PostTile(post: e, isLast: false),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
