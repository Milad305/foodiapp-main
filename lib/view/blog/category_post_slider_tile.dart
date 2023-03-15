import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:salamatiman/model/blog/post_by_category_model.dart';

import '../../service/blog/post-single.dart';

class CategoryPostSliderTile extends StatelessWidget {
  final Articles post;

  const CategoryPostSliderTile({Key? key, required this.post})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => PostSingle(postID: post.id)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Container(
          width: Get.width * 0.30,
          height: 150.sp,
          margin: const EdgeInsets.only(left: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(7),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                spreadRadius: 0.0,
                blurRadius: 5.0,
                offset: const Offset(0, 0),
              )
            ],
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: CachedNetworkImage(
                    imageUrl: "${post.preview}",
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Image.asset(
                      "assets/images/placeholder.png",
                      fit: BoxFit.cover,
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      "assets/images/placeholder.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.grey.shade700,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 7, right: 7, bottom: 5, top: 40),
                  child: Text(
                    "${post.title}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.sp,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
