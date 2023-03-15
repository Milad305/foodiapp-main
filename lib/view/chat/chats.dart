import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
//import 'package:salamatiman/view/chat/chat-tile/chatle/image-tile.dart';
import 'package:salamatiman/getx/chat/chat-getter.dart';
import 'package:salamatiman/utils/constants.dart';
import 'package:salamatiman/view/chat/bio/bio-main.dart';
import 'package:salamatiman/view/chat/chat-tile/chat-rating.dart';

import 'chat-form.dart';
import 'chat-tile/audio-tile.dart';
import 'chat-tile/chat-tile.dart';
import 'chat-tile/image-tile.dart';

class Chats extends GetView<ChatGetter> {
  var chatID;
  final user;
  var me = GetStorage().read('UserInfo');

  Chats({Key? key, required this.chatID, required this.user})
      : super(key: key) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.chatInput.value = "";
      controller.lastChat.value = 0;
      controller.myChatId.value = 0;
      controller.myChatPage.value = 1;
      controller.myChatTotalPage.value = 1;
      chatID =
          controller.lastChat.value != 0 ? controller.lastChat.value : chatID;

      controller.setAuth(expertID: user);
      controller.getConsultantsMessages(chatID: chatID, page: 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFf8f8f8),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.sp),
              bottomRight: Radius.circular(30.sp),
            ),
            image: const DecorationImage(
              image: AssetImage("assets/images/chat/chat-bg3.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: Container(
            color: const Color(0xFFf8f8f8).withOpacity(0.7),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(() => BioMain(user: user));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30.sp),
                      bottomRight: Radius.circular(30.sp),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Constants.secondaryColor,
                      ),
                      child: AppBar(
                        backgroundColor: Constants.secondaryColor,
                        surfaceTintColor: Constants.secondaryColor,
                        foregroundColor: Colors.white,
                        title: UserAppBar(user: user),
                        toolbarHeight: 80,
                        leadingWidth: 24,
                      ),
                    ),
                  ),
                ),
                Obx(() {
                  return AnimatedContainer(
                    duration: Duration(milliseconds: 400),
                    child: controller.moreChatLoading.value
                        ? Container(
                            width: double.infinity,
                            height: 70.sp,
                            padding: EdgeInsets.only(top: 10.sp),
                            alignment: Alignment.topCenter,
                            child: Text("لطفا صبر کنید"),
                          )
                        : Container(),
                  );
                }),
                Expanded(
                  child: Obx(() {
                    if (controller.loading.value) {
                      return Center(
                        child: SpinKitThreeBounce(
                          color: Colors.black45,
                          size: 17.sp,
                        ),
                      );
                    }

                    chatID = chatID ?? 0;

                    List chats = controller.chatList[chatID] != null
                        ? controller.chatList[chatID].toList()
                        : [];
                    return Container(
                      width: double.infinity,
                      height: double.infinity,
                      padding: EdgeInsets.all(3.sp),
                      child: Column(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                              child: ListView.builder(
                                controller:
                                    controller.chatScrollController.value,
                                reverse: true,
                                itemCount: chats.length,
                                itemBuilder: (context, index) {
                                  final chat = chats[index];
                                  final isMe =
                                      me["id"] != chat["from"] ? false : true;
                                  return isMe
                                      ? Dismissible(
                                          key: Key(chat["id"].toString()),
                                          dragStartBehavior:
                                              DragStartBehavior.start,
                                          behavior: HitTestBehavior.opaque,
                                          direction:
                                              DismissDirection.startToEnd,
                                          background: Container(
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                            ),
                                            alignment: Alignment.centerRight,
                                            padding: EdgeInsets.only(right: 15),
                                            child: Text(
                                              "حذف کردن",
                                              style: TextStyle(
                                                  fontSize: 17.sp,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          confirmDismiss:
                                              (DismissDirection val) =>
                                                  controller.removeMessage(
                                                      id: chat["id"],
                                                      indexOf: index,
                                                      chatID: chatID),
                                          child: ChatType(chat["content_type"],
                                              chat: chat, isMe: isMe),
                                        )
                                      : ChatType(chat["content_type"],
                                          chat: chat, isMe: isMe);
                                  return Text("data");
                                },
                              ),
                            ),
                          ),
                          Obx(
                            () {
                              if (controller.chatStatus.value == "open" ||
                                  !controller.messageClose.contains(chatID)) {
                                return Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade300,
                                        spreadRadius: 0.0,
                                        blurRadius: 5.0,
                                      )
                                    ],
                                  ),
                                  child: ChatForm(chatID: chatID, user: user),
                                );
                              }
                              return Container(
                                height: 70.sp,
                                padding: EdgeInsets.only(bottom: 17.sp),
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  "چت توسط متخصص بسته شده",
                                  style: TextStyle(
                                    fontSize: 17.sp,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget ChatType(type, {required isMe, required chat}) {
    switch (type) {
      case "rating":
        return ChatRating(
          forMe: isMe,
          chat: chat,
        );
      case "text":
        return ChatTile(
          forMe: isMe,
          chat: chat,
        );
      case "image":
        return ImageTile(
          disc: "",
          image: chat,
          forMe: isMe,
        );
      case "music":
        return AudioTile(forMe: isMe, file: chat);
      default:
        return Container();
    }
    return Container();
  }

  Widget UserAppBar({required user}) {
    return Container(
      width: double.infinity,
      color: Constants.secondaryColor,
      child: Wrap(
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          SizedBox(
            width: 70,
            height: 70,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: IconButton(
                onPressed: null,
                icon: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    'https://${Constants.BaseUrl}${user.img}',
                    width: 60,
                    height: 60,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: TextStyle(fontSize: 19),
                ),
                /*Text(
                  '',
                  style: TextStyle(fontSize: 16, color: Colors.green),
                ),*/
              ],
            ),
          )
        ],
      ),
    );
  }
}

class DurationState {
  DurationState({this.progress, this.buffered, this.total});

  final Duration? progress;
  final Duration? buffered;
  final Duration? total;
}

void printLongString(String text) {
  final RegExp pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern
      .allMatches(text)
      .forEach((RegExpMatch match) => print(match.group(0)));
}
