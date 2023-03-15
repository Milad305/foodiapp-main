
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';

class BackgroundRoundedPic extends StatelessWidget {
  const BackgroundRoundedPic({
    Key? key,required this.imageAsset,
  }) : super(key: key);
 final imageAsset ;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height / 4.5,
      width: Get.width,
      decoration:  BoxDecoration(
          boxShadow: <BoxShadow>[BoxShadow(
            color: Constants.shadeColor,blurRadius: 10)],
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          image:  DecorationImage(
          image: AssetImage(imageAsset),fit: BoxFit.fill)),
      foregroundDecoration: const BoxDecoration(
          
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          gradient: LinearGradient(
            colors: Constants.profiileBg,
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter
            )
         ) ,
    );
  }
}