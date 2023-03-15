import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:salamatiman/model/blog/post_by_category_model.dart';

import '../../service/blog/post-single.dart';
import 'blog_category_child.dart';
import 'blog_category_posts.dart';
import 'category_post_slider_tile.dart';

class CategoryPostSlider extends StatelessWidget {
  final PostByCategoryModel category;
  final List<PostByCategoryModel> categorys;
  const CategoryPostSlider(
      {Key? key, required this.category, required this.categorys})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (category.articles!.isEmpty) {
      return Container();
    }
    final posts = category.articles!;
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 15),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    "${category.title}",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      List<PostByCategoryModel> itemChild = [];
                      categorys.map((item) {
                        if (item.parent == category.id) {
                          itemChild.add(item);
                        }
                      }).toList();

                      if (category.articles!.length > 1) {
                        if (itemChild.isNotEmpty) {
                          Get.to(() => BlogCategoryChild(
                              category: category, childs: itemChild));
                        } else {
                          Get.to(() => BlogCategoryPosts(category: category));
                        }
                      } else if (category.articles!.length == 1) {
                        if (itemChild.isNotEmpty) {
                          Get.to(() => BlogCategoryChild(
                              category: category, childs: itemChild));
                        } else {
                          Get.to(() => PostSingle(
                                postID: category.articles![0].id,
                              ));
                        }
                      }
                    },
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          "مشاهده همه",
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        Icon(
                          Icons.keyboard_arrow_left_sharp,
                          size: 16.sp,
                          color: Colors.grey.shade600,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: posts
                      .map<Widget>((post) => CategoryPostSliderTile(post: post))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getChilds({required id}) {
    List<PostByCategoryModel> childs = [];
    categorys.map((item) {
      if (item.parent == category.id) {
        childs.add(item);
        categorys.map((e) {
          if (item.id == e.parent) {
            getChildChilds(item: item);
          }
        });
      }
    }).toList();
  }

  getChildChilds({item}) {
    List<PostByCategoryModel> child = [];
    categorys.map((e) {
      if (item.parent == category.id) {
        child.add(e);
        if (item.id == item.id) {
          getChildChilds(item: e);
        }
      }
    }).toList();
  }
}
