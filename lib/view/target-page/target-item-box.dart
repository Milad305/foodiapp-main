import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:salamatiman/getx/target/target-getter.dart';
class TargetItemBox extends GetView<PersonTargetGeter> {
  final text,imageID,isActive;
  const TargetItemBox({Key? key, required this.text, required this.imageID,required this.isActive}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      child: Container(
        width: 80,
        height: 80,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isActive? Colors.grey.shade200:Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/target/"+imageID.toString()+".png",scale: 27,),
            Text(text.toString(),style: TextStyle(fontSize: 12.sp),),
          ],
        ),
      ),
      drawSurfaceAboveChild: isActive,
      style: NeumorphicStyle(
          shape: NeumorphicShape.concave,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
          depth: 8,
          lightSource: LightSource.topLeft,
          color: Colors.grey.shade400
      ),

    );;
  }
}
