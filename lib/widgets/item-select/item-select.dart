import 'dart:math';

import 'package:flutter/material.dart';

class ItemSelected extends StatelessWidget {
  final isSelected;
  final Widget back, front;
  const ItemSelected(
      {Key? key,
      required this.isSelected,
      required this.back,
      required this.front})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Duration? _duration = Duration(milliseconds: 400);
    return TweenAnimationBuilder(
      duration: _duration!,
      curve: Curves.easeOut,
      tween: Tween<double>(begin: 0, end: isSelected ? 180 : 0),
      builder: (context, dynamic value, child) {
        var content = value >= 90 ? back : front;
        return _RotationY(
          rotationY: value,
          child: _RotationY(
            rotationY: value >= 90 ? 180 : 0,
            child: content,
          ),
        );
      },
    );
  }
}

class _RotationY extends StatelessWidget {
  static const double degrees2Radians = pi / 180;

  final Widget child;
  final double rotationY;

  const _RotationY({Key? key, required this.child, this.rotationY = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: FractionalOffset.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateY(rotationY * degrees2Radians),
      child: child,
    );
  }
}
