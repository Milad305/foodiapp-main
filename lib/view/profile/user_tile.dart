import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:salamatiman/utils/constants.dart';

class UserTile extends StatelessWidget {
 
  final Widget icon;
  final String title;
  final String keyTitle;
  final String value;
  const UserTile({
    Key? key,
   
    required this.icon,
    required this.title,
    required this.keyTitle,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
     
      width: (Get.width * 0.50)-30 ,
      height: Get.height/15,
      
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Constants.shadeColor,
            blurStyle: BlurStyle.normal,
            blurRadius: 10,
           
           
          )
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        child: Row(
        
          children: [
             SizedBox(width:  Get.width/80),
            icon,
             SizedBox(width: Get.width/80),
            FittedBox(child: Text("$title",style: TextStyle(fontSize: 12.sp), maxLines: 1, overflow: TextOverflow.ellipsis)),
            VerticalDivider(color: Constants.shadeColor,
            indent: Get.height/60,
            endIndent: Get.height/60,
            ),
            Text(
            keyTitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.grey.shade300),
          ),
          
          FittedBox(
            child: Text(
              value.toPersianDigit(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          ],
        ),
      ),
    );
  }
}
