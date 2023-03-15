import 'package:flutter/material.dart';

class ProgressBarMacroMicro extends StatelessWidget {
  final width, progress, color;
  const ProgressBarMacroMicro(
      {Key? key,
      required this.width,
      required this.progress,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var progressInit = (progress * width) / 100;
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Container(
          width: double.infinity,
          height: 12,
          decoration: BoxDecoration(
            color: Color(0xffe5e5e5),
          ),
          child: Stack(
            children: [
              FractionallySizedBox(
                widthFactor: (progress / 100),
                child: Container(
                  decoration: BoxDecoration(
                      color: color, borderRadius: BorderRadius.circular(50)),
                  width: progressInit,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
