import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:salamatiman/model/blog/post_by_category_model.dart';

import '../../service/blog/post-single.dart';

class PostTile extends StatelessWidget {
  final Articles post;
  final isLast;
  const PostTile({Key? key, required this.post, required this.isLast})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => PostSingle(
            postID: post.id,
          )),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(7),
        child: ListTile(
          contentPadding: EdgeInsets.all(0),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(9),
            child: CachedNetworkImage(
              height: 70,
              width: 70,
              imageUrl: "${post.preview}",
              fit: BoxFit.cover,
              placeholder: (context, url) => Image.asset(
                "assets/images/placeholder.png",
                fit: BoxFit.fill,
              ),
              errorWidget: (context, url, error) => Image.asset(
                "assets/images/placeholder.png",
                fit: BoxFit.fill,
              ),
            ),
          ),
          title: Align(
            alignment: Alignment.centerRight,
            child: Text(
              post.title.toString(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 14.sp),
            ),
          ),
          subtitle: Text(
            post.publishedAt == null
                ? ""
                : post.publishedAt.toString().substring(0, 10).toPersianDate(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 15.sp, color: Colors.grey),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios_rounded,
            size: 16.sp,
          ),
        ),
      ),
    );
  }
}
