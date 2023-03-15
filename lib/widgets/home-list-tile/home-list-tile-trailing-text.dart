import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import 'home-list-tile-trailing.dart';
class HomeListTileTrailingText extends StatelessWidget {
  final  title;
  final  number;
  HomeListTileTrailingText({Key? key, this.title,this.number}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: number.toString().toPersianDigit(),
              ),
              TextSpan(text: "  "),
              TextSpan(text: '$title'),
            ],
          ),
        ),
        SizedBox(width: 4,),
        HomeListTileTrailing(),
      ],
    );
  }
}
