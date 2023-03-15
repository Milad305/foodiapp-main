import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:salamatiman/getx/chat/chat-getter.dart';
import 'package:salamatiman/utils/constants.dart';
import 'package:salamatiman/view/chat/my_specialists.dart';
import 'package:salamatiman/view/chat/specialists.dart';

class ChatMain extends StatelessWidget {
  const ChatMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/images/chaticon.png", width: Get.width * 0.50),
          SizedBox(height: 20.sp),
          Text(
            "بزودی فعال خواهد شد",
            style: TextStyle(
              fontSize: 17.sp,
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMain2 extends GetView<ChatGetter> {
  ChatMain2({Key? key}) : super(key: key) {
    Get.put(ChatGetter());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: controller.tabInitial.value,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Color(0xfff3f3f3),
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 0, right: 0, left: 0, bottom: 5),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 7),
                decoration: BoxDecoration(
                  color: Constants.secondaryColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                ),
                child: TabBar(
                  labelColor: Colors.white,
                  indicatorColor: Colors.transparent,
                  onTap: (val) {
                    controller.tabInitial(val);
                  },
                  tabs: [
                    Obx(
                      () => Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 13),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: controller.tabInitial.value == 0
                              ? Colors.black12
                              : Colors.transparent,
                        ),
                        alignment: Alignment.center,
                        child:
                            Text('متخصص‌ها', style: TextStyle(fontSize: 17.sp)),
                      ),
                    ),
                    Obx(() => Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 13),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: controller.tabInitial.value == 1
                                ? Colors.black12
                                : Colors.transparent,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'پزشکان من',
                            style: TextStyle(fontSize: 17.sp),
                          ),
                        )),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Obx(() {
                      final chats = controller.chats.value;
                      return Specialists();
                    }),
                    Obx(() {
                      final chats = controller.chats.value;
                      return MySpecialists();
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
