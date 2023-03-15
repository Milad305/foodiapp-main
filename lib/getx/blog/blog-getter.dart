import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:salamatiman/repo/api-status.dart';
import 'package:salamatiman/service/blog/blog.dart';

import '../../model/blog/post_by_category_model.dart';

class PostGetter extends GetxController {
  RxList<PostByCategoryModel> postByCategory = <PostByCategoryModel>[].obs;
  RxList postList = [].obs;
  RxList searchPostList = [].obs;
  RxList postListData = [].obs;
  RxList postListCategory = [].obs;
  RxList postListDataCategory = [].obs;
  RxList singlePost = [].obs;
  RxBool loading = false.obs;
  RxBool loadingBtn = false.obs;
  RxInt page = 1.obs;
  RxInt sliderPage = 0.obs;

  Timer? timerSlider;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void dispose() {
    Get.delete<PostGetter>();
    // TODO: implement dispose
    timerSlider!.cancel();
    super.dispose();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    timerSlider!.cancel();
    super.onClose();
  }

  getBlogArticle() async {
    loading(true);
    postList.value = [];
    try {
      var res = await BlogService().getBlogArticle(page: page.value);
      if (res is Success) {
        var json = jsonDecode(res.response.toString());
        postList.add(json);
        json["data"].map((e) => postListData.add(e)).toList();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    loading(false);
    update();
  }

  getSearchPosts({required searchTxt}) async {
    loading(true);
    searchPostList([]);
    try {
      var res = await BlogService().getSearchPosts(searchTxt: searchTxt);
      if (res is Success) {
        var json = jsonDecode(res.response.toString());
        searchPostList.add(json);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    loading(false);
    update();
  }

  gePostsBytCategory() async {
    loading(true);
    postByCategory([]);
    try {
      var res = await BlogService().getPostsBytCategory();
      if (res is Success) {
        var json = jsonDecode(res.response.toString());
        json.map((item) => print(item)).toList();
        json
            .map((item) =>
                postByCategory.add(PostByCategoryModel.fromJson(item)))
            .toList();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    loading(false);
    update();
  }

  getPostBytCategory({required cid}) async {
    loading(true);
    postListCategory([]);
    postListDataCategory([]);
    try {
      var res = await BlogService().getPostBytCategory(cid: cid);
      if (res is Success) {
        var json = jsonDecode(res.response.toString());
        postListCategory.add(json);
        json.map((e) => postListDataCategory.add(e)).toList();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    loading(false);
    update();
  }

  getSingle({required postId}) async {
    singlePost.value = [];
    var res = await BlogService().getSingle(postId: postId);
    if (res is Success) {
      var json = jsonDecode(res.response.toString());
      singlePost.add(json);
      update();
    }
  }

  getBlogArticleMore({required froPage}) async {
    loadingBtn.value = true;
    //loading(true);
    var res = await BlogService().getBlogArticle(page: froPage);
    if (res is Success) {
      var json = jsonDecode(res.response.toString());
      json["data"].map((e) => postListDataCategory.add(e)).toList();
      postListCategory.value = [];
      postListCategory.add(json);
    }
    loadingBtn.value = false;
    //loading(false);
    update();
  }
}
