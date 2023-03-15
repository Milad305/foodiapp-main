import 'dart:io';
import 'dart:math' as math;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:salamatiman/utils/constants.dart';

import '../../getx/chat/chat-getter.dart';

class ChatForm extends GetView<ChatGetter> {
  var chatID;
  final user;

  ChatForm({Key? key, required this.chatID, required this.user}) {
    Get.put(ChatGetter());
  }

  TextEditingController txtController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      margin: EdgeInsets.all(5),
      child: Container(
        child: TextField(
          controller: txtController,
          style: TextStyle(),
          maxLines: 5,
          minLines: 1,
          keyboardType: TextInputType.multiline,
          onChanged: (val) {
            controller.chatInput(val.toString());
          },
          onSubmitted: (val) {
            sendText();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          onEditingComplete: () {
            sendText();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "پیام",
            hintStyle: TextStyle(color: Colors.grey.shade500),
            icon: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(math.pi),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  sendText();
                  FocusManager.instance.primaryFocus?.unfocus();
                },
              ),
            ),
            // suffixIcon: Container(
            //   child: Wrap(
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.only(top: 12, left: 12),
            //         child: GestureDetector(
            //           child: Obx(() {
            //             return RippleAnimation(
            //               repeat: controller.isRecord.value ? true : false,
            //               color: Colors.blue,
            //               minRadius: 20,
            //               ripplesCount: 6,
            //               duration: const Duration(milliseconds: 1000),
            //               delay: const Duration(milliseconds: 200),
            //               child: Icon(
            //                 Icons.keyboard_voice_outlined,
            //                 color: controller.isRecord.value
            //                     ? Colors.blue
            //                     : Colors.black87,
            //               ),
            //             );
            //           }),
            //           onTap: () {
            //             Fluttertoast.showToast(
            //                 msg: "دستو رو میکروفن نگهدار تا صدات ضبط شه");
            //           },
            //           onLongPressEnd: (LongPressEndDetails val) {
            //             stopRecord();
            //           },
            //           onLongPressStart: (LongPressStartDetails val) {
            //             startRecord();
            //           },
            //         ),
            //       ),
            //       IconButton(
            //         icon: Icon(
            //           Icons.image_outlined,
            //           color: Colors.black87,
            //         ),
            //         onPressed: () async {
            //           await sendFile();
            //         },
            //       ),
            //     ],
            //   ),
            // ),
            iconColor: Constants.primaryColor2,
          ),
        ),
      ),
    );
  }

  void stopRecord() {
    // controller.isRecord(false);
    // controller.stopRecord(user: user, chatID: chatID);
  }

  void startRecord() async {
    // HapticFeedback.mediumImpact();
    // await controller.initRecorder();
    // controller.isRecord(true);
  }

  sendFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: false);
    final name = result?.names[0];
    final path = result?.files[0].path;
    final format = name.toString().split('.').last;
    final imageFormat = [
      "jpg",
      "JPG",
      "jpeg",
      "JPEG",
      "png",
      "PNG",
      "gif",
      "GIF"
    ];
    if (imageFormat.contains(format)) {
      var bytes = await File(path.toString()).readAsBytes();
      controller.sendMessageFile(
          image: bytes,
          type: "image",
          chatID: chatID,
          to: user.uid,
          fileName: name);
    }
  }

  void sendText() {
    controller.sendMessage(
        chatID: chatID,
        to: user.uid,
        type: "text",
        text: controller.chatInput.value.toString());
    controller.chatInput("");
    txtController.clear();
  }
}
