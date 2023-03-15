import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class ChatTile extends StatelessWidget {
  final bool forMe;
  final chat;
  const ChatTile({Key? key, required this.forMe, required this.chat})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: forMe ? Alignment.centerRight : Alignment.centerLeft,
      padding: const EdgeInsets.all(5),
      margin: EdgeInsets.only(left: forMe ? 20 : 0, right: forMe ? 0 : 20),
      child: Column(
        children: [
          Align(
            alignment: forMe ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color:
                    forMe ? const Color(0xFFE6E6E9) : const Color(0xFFD8D8D9),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(forMe ? 13 : 0),
                  topLeft: const Radius.circular(13),
                  bottomRight: Radius.circular(forMe ? 0 : 13),
                  topRight: const Radius.circular(13),
                ),
              ),
              child: Text(
                chat["content"].toString(),
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 17,
                ),
                textAlign: forMe ? TextAlign.right : TextAlign.left,
              ),
            ),
          ),
          if (chat["createdAt"] != null) ...[
            SizedBox(height: 2),
          ],
          if (chat["createdAt"] != null) ...[
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: LayoutBuilder(builder: (context, constraints) {
                final time = chat["createdAt"]
                    .toString()
                    .split("T")[1]
                    .toString()
                    .split(".")[0]
                    .toString()
                    .split(":");
                return SizedBox(
                  width: double.infinity,
                  child: Text(
                    time[1].toString().toPersianDigit() +
                        ":" +
                        time[2].toString().toPersianDigit(),
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 15.sp,
                    ),
                    textAlign: forMe ? TextAlign.right : TextAlign.left,
                  ),
                );
              }),
            ),
          ]
        ],
      ),
    );
  }
}
