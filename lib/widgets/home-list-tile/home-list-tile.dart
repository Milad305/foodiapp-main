import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:salamatiman/utils/constants.dart';
import 'package:salamatiman/widgets/home-list-tile/home-list-tile-trailing.dart';

class HomeListTile extends StatelessWidget {
  final Widget title;
  final Widget subtitle;
  final Widget icon;
  Widget? trailing;

  HomeListTile(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.icon,
      this.trailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:5,right: 5),
      child: Container(
        width: Get.width/1.12,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(11),color: Colors.white ,
        boxShadow: <BoxShadow>[BoxShadow(color: Constants.shadowColor,blurRadius: 10)]),
        
        child: ListTile(
          style: ListTileStyle.drawer,
          title: title,
          
          subtitle: FittedBox(child: subtitle),
          leading: icon,
          trailing: trailing == null ? HomeListTileTrailing() : trailing,
        ),
      ),
    );
  }
}
