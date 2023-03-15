import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salamatiman/utils/constants.dart';

class ChatRating extends StatelessWidget {
  final bool forMe;
  final chat;
  const ChatRating({Key? key, required this.forMe, required this.chat})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final star = int.parse(chat["content"].toString());
    return Container(
      width: double.infinity,
      alignment: forMe ? Alignment.centerRight : Alignment.centerLeft,
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          Align(
            alignment: forMe ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(10.sp),
              decoration: BoxDecoration(
                color: const Color(0xFF8D8DF5).withOpacity(0.4),
                borderRadius: BorderRadius.circular(13.sp),
              ),
              child: Center(
                child: Wrap(
                  children: [
                    Icon(
                      Icons.star,
                      color: star >= 1 ? Constants.secondaryColor : Colors.grey,
                    ),
                    Icon(
                      Icons.star,
                      color: star >= 2 ? Constants.secondaryColor : Colors.grey,
                    ),
                    Icon(
                      Icons.star,
                      color: star >= 3 ? Constants.secondaryColor : Colors.grey,
                    ),
                    Icon(
                      Icons.star,
                      color: star >= 4 ? Constants.secondaryColor : Colors.grey,
                    ),
                    Icon(
                      Icons.star,
                      color: star >= 5 ? Constants.secondaryColor : Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
