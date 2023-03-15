import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:salamatiman/utils/constants.dart';
import 'package:salamatiman/view/chat/chats.dart';

class SpecialisTile extends StatelessWidget {
  final specialist, chat_id;
  const SpecialisTile(
      {Key? key, required this.specialist, required this.chat_id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, String> expertTypes = {
      "physician": "پزشک",
      "dietician": "متخصص تغذیه",
      "coach": "مربی",
      "trainer": "مربی خصوصی",
      "nutritionist": "مشاور تغذیه",
    };
    return GestureDetector(
      onTap: () {
        Get.to(() => Chats(chatID: chat_id, user: specialist),
            transition: Transition.leftToRight);
      },
      child: Container(
        width: double.infinity,
        height: 80,
        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              child: Container(
                width: Get.width - (70),
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  ),
                ),
                padding: EdgeInsets.only(
                  right: 40,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${specialist.name}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey.shade700,
                        )),
                    LayoutBuilder(builder: (context, constraints) {
                      final hasKey = expertTypes.containsKey(specialist.type);
                      return Text(
                          "${hasKey ? expertTypes[specialist.type] : specialist.type}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.grey.shade700,
                          ));
                    }),
                  ],
                ),
              ),
            ),
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFFf8f8f8),
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                    color: const Color(0xFFf8f8f8),
                    width: 7,
                    style: BorderStyle.solid),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  ("https://${Constants.BaseUrl}${specialist.img}").toString(),
                  width: 80,
                  height: 80,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
