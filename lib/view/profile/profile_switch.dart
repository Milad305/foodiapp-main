import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileSwitch extends StatelessWidget {
  final primaryColor, title;
  final bool value;
  final ValueChanged<bool>? onChanged;
  const ProfileSwitch({
    Key? key,
    required this.primaryColor,
    required this.title,
    required this.onChanged,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Wrap(
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          SizedBox(
            width: 50,
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeColor: primaryColor,
            ),
          ),
          SizedBox(width: 5),
          Container(
            child: Text(
              "${title}",
              style: TextStyle(
                fontSize: 15.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
