import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class MyListTile extends StatelessWidget {
  final title;
  final Color bgColor;
  final Color textColor;
  const MyListTile(
      {Key? key,
      required this.title,
      required this.bgColor,
      required this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      margin: const EdgeInsets.all(20),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: bgColor, //Color(0xFFF08648)
          borderRadius: BorderRadius.circular(7),
          boxShadow: [
            BoxShadow(
              color: bgColor,
              blurStyle: BlurStyle.solid,
              blurRadius: 5.0,
              offset: const Offset(0.0, 0.0),
              spreadRadius: 1.0,
            )
          ]),
      child: Text(
        title.toString().toPersianDigit(),
        style: const TextStyle(
          fontSize: 19,
        ),
      ),
    );
  }
}
