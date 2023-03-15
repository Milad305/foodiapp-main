import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:salamatiman/getx/chat/chat-getter.dart';

import 'specialist-tile.dart';

class Specialists extends GetView<ChatGetter> {
  const Specialists({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.loading.value
          ? Center(
              child: SpinKitThreeBounce(
                color: Colors.black45,
                size: 17,
              ),
            )
          : controller.specialists.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(top: 0, bottom: 10),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.specialists.length,
                    itemBuilder: (context, index) {
                      final specialist = controller.specialists[index];
                      var chat_id = 0;
                      for (var i = 0; i < controller.consultants.length; i++) {
                        if (controller.consultants[i].expertId ==
                            specialist.uid) {
                          chat_id = int.parse(
                              controller.consultants[i].id.toString());
                        }
                      }

                      return SpecialisTile(
                        specialist: specialist,
                        chat_id: chat_id,
                      );
                    },
                  ),
                )
              : Center(
                  child: Text("خطا در دریافت لیست مشاور ها"),
                );
    });
  }
}
