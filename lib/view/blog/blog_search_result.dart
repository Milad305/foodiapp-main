import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../getx/blog/blog-getter.dart';
import '../../model/blog/post_by_category_model.dart';
import '../../utils/constants.dart';
import 'post_tile.dart';

class BlogSearchResult extends GetView<PostGetter> {
  Timer? _timer;
  BlogSearchResult({Key? key}) : super(key: key) {
    Get.lazyPut(() => PostGetter);
  }

  TextEditingController _txtController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        surfaceTintColor: Constants.primaryColor,
        toolbarHeight: 40,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300, width: 1),
                borderRadius: BorderRadius.circular(7),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    offset: Offset(0, 0),
                    blurRadius: 5.0,
                    spreadRadius: 0.0,
                  ),
                ],
              ),
              child: TextFormField(
                controller: _txtController,
                onChanged: (val) {
                  if (_timer?.isActive ?? false) _timer!.cancel();
                  _timer = Timer(const Duration(seconds: 2), () async {
                    Get.find<PostGetter>()
                        .getSearchPosts(searchTxt: val.toString());
                  });
                },
                onEditingComplete: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  Get.find<PostGetter>().getSearchPosts(
                      searchTxt: _txtController.text.toString());
                },
                autofocus: true,
                cursorColor: Colors.grey.shade600,
                decoration: InputDecoration(
                  hintText: "جستجوی مقاله ها",
                  hintStyle: TextStyle(color: Colors.grey.shade300),
                  isDense: true,
                  disabledBorder: InputBorder.none,
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.only(bottom: 0, top: 10.sp, right: 7),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      Get.find<PostGetter>().getSearchPosts(
                          searchTxt: _txtController.text.toString());
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 5.sp),
                      decoration: BoxDecoration(
                          border: Border(
                        right:
                            BorderSide(color: Colors.grey.shade300, width: 1),
                        top: const BorderSide(
                            color: Colors.transparent, width: 4),
                        bottom: const BorderSide(
                            color: Colors.transparent, width: 4),
                      )),
                      child: Icon(
                        Icons.search,
                        size: 27.sp,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Obx(() {
                final posts = controller.searchPostList.value;
                final loading = controller.loading.value;
                return loading
                    ? Center(
                        child: SpinKitThreeBounce(
                          color: Colors.black45,
                          size: 17.sp,
                        ),
                      )
                    : posts.isEmpty
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: ListView.builder(
                              itemCount: posts[0]["data"].length,
                              itemBuilder: (context, index) {
                                final thisPost = posts[0]["data"][index];
                                final post = Articles(
                                    title: thisPost["title"],
                                    id: thisPost["id"],
                                    abstract: thisPost["abstract"],
                                    content: thisPost["content"],
                                    preview: thisPost["preview"],
                                    publishedAt: thisPost["published_at"]);
                                return Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.symmetric(vertical: 5.sp),
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 5.sp),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.shade300,
                                          offset: const Offset(0, 0),
                                          spreadRadius: 0.0,
                                          blurRadius: 5.0.sp,
                                        )
                                      ]),
                                  child: PostTile(post: post, isLast: false),
                                );
                              },
                            ),
                          );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onRefresh() async {
    int currentPage = controller.searchPostList[0]["current_page"];
    int total = controller.searchPostList[0]["total"];
    int to = controller.searchPostList[0]["to"];
    if (total > to) {
      await controller.getBlogArticleMore(froPage: currentPage + 1);
    }
  }
}
