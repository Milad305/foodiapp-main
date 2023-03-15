import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salamatiman/view/food/meal-main/food-copy-and-add.dart';

import '../food-category.dart';

class FoodEmpty extends StatelessWidget {
  final group, title;
  const FoodEmpty({Key? key, @required this.title, required this.group})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: Text.rich(
              TextSpan(text: "هنوز غذایی اضافه نکردی میتونی از ", children: [
                TextSpan(
                  text: "اینجا",
                  style: TextStyle(color: Color(0xFF2dd3c2)),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => Get.to(() => FoodCategory(
                          group: group,
                          title: title,
                        )),
                ),
                TextSpan(text: " غذاتو اضافه کنی")
              ]),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          FoodCopyAndAdd(group: group, title: title)
        ],
      ),
    );
  }
}
