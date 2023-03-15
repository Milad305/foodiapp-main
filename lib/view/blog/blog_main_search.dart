import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'blog_search_result.dart';

class BlogMainSearch extends StatelessWidget {
  const BlogMainSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => BlogSearchResult()),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(7),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                offset: const Offset(0, 0),
                blurRadius: 5.0,
                spreadRadius: 0.0,
              ),
            ]),
        child: Padding(
          padding: const EdgeInsets.only(right: 5),
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                "جستجو مقاله ها...",
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.grey.shade500,
                ),
              ),
              Container(
                height: 45,
                width: 45,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(
                  color: Colors.grey.shade300,
                  width: 1,
                ))),
                child: const Icon(Icons.search),
              )
            ],
          ),
        ),
      ),
    );
  }
}
