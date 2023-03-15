import 'dart:math';

import 'package:flutter/material.dart';

class RotationBox extends StatelessWidget {
  static const double degrees2Radians = pi / 360;

  final Widget child;
  final double rotation;

  const RotationBox({Key? key, required this.child, this.rotation = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: AlwaysStoppedAnimation(rotation),
      child: child,
    );
  }
}
