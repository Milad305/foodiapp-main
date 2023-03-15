import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecipesTile extends StatelessWidget {
  final Widget child;
  final String title;
  const RecipesTile({Key? key, required this.child, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 15.sp),
      child: Column(
        children: [
          if (title.toString().isNotEmpty) ...[
            SizedBox(
              width: double.infinity,
              child: Text(
                title.toString(),
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black87.withOpacity(0.7),
                ),
                textAlign: TextAlign.right,
              ),
            ),
            SizedBox(height: 7.sp),
          ],
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(5.sp),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.sp),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 7.0,
                  spreadRadius: 1.0,
                  offset: Offset(0.0, 3.0.sp),
                )
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(7.sp),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
