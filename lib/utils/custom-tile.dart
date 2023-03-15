import 'package:flutter/material.dart';
import 'package:salamatiman/utils/constants.dart';

class CustomTile extends StatelessWidget {
  final Widget child;
  const CustomTile({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Constants.secondaryHeaderColor,
        borderRadius: BorderRadius.circular(7),
        boxShadow: [
          BoxShadow(
            color: Constants.shadowColor,
            offset: Offset(0, 0),
            blurRadius: 10,
            blurStyle: BlurStyle.solid,
          )
        ],
      ),
      child: ClipRRect(borderRadius: BorderRadius.circular(7), child: child),
    );
  }
}
