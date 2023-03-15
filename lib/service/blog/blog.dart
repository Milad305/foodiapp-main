import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:salamatiman/service/base.dart';

class BlogService extends BaseService {
  // getBlogArticle({required page}) async {
  //   try {
  //     var token = await GetStorage().read('UserToken');
  //     return await BaseService.post(
  //         path: "article/index",
  //         hasToken: true,
  //         hasHeader: true,
  //         loading: false,
  //         body: {"token": token, "page": page});
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  getBlogArticle({required page}) async {
    try {
      return await BaseService.getCustomUrl(false,
          customUrl: 'salamatiman.ir', path: "mag/wp-json/v1/posts/10");
    } catch (e) {
      print(e);
    }
  }

  getPostsBytCategory() async {
    try {
      return await BaseService.getCustomUrl(false,
          customUrl: 'salamatiman.ir',
          path: "mag/wp-json/v1/catposts/author/1");
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
  // getPostsBytCategory() async {
  //   try {
  //     var token = await GetStorage().read('UserToken');
  //     return await BaseService.post(
  //         path: "article/group_by_categories",
  //         hasToken: true,
  //         hasHeader: true,
  //         loading: false,
  //         body: {"token": token});
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print(e);
  //     }
  //   }
  // }

  getSearchPosts({required searchTxt}) async {
    try {
      var token = await GetStorage().read('UserToken');
      return await BaseService.post(
          path: "article/search",
          hasToken: true,
          hasHeader: true,
          loading: false,
          body: {"token": token, "q": searchTxt.toString()});
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  getPostBytCategory({required cid}) async {
    try {
      return await BaseService.getCustomUrl(false,
          customUrl: 'salamatiman.ir', path: "mag/wp-json/v1/bycategory/$cid");
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
  // getPostBytCategory({required cid}) async {
  //   try {
  //     var token = await GetStorage().read('UserToken');
  //     return await BaseService.post(
  //         path: "article/get_by_category",
  //         hasToken: true,
  //         hasHeader: true,
  //         loading: false,
  //         body: {"token": token, "cid": cid});
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print(e);
  //     }
  //   }
  // }

  getSingle({required postId}) async {
    return await BaseService.getCustomUrl(false,
        customUrl: 'salamatiman.ir', path: "mag/wp-json/v1/post/$postId");
  }
  // getSingle({required postId}) async {
  //   var token = await GetStorage().read('UserToken');
  //   var res = await BaseService.post(
  //       path: "article/get",
  //       hasToken: true,
  //       hasHeader: true,
  //       loading: false,
  //       body: {"token": token, "id": postId});
  //   return res;
  // }
}
