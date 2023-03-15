import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:just_audio/just_audio.dart';
import 'package:salamatiman/model/chat/consultants-model.dart';
import 'package:salamatiman/model/chat/specialists-model.dart';
import 'package:salamatiman/repo/api-status.dart';
import 'package:salamatiman/service/chat/chat-server.dart';
import 'package:salamatiman/utils/constants.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatGetter extends GetxController {
  RxInt tabInitial = 0.obs;
  RxList imagesSelected = [].obs;
  RxBool loading = true.obs;

  //final recorder = FlutterSoundRecorder();
  RxBool isRecord = false.obs;

  RxString chatInput = "".obs;
  AudioPlayer audioPlayer = AudioPlayer();
  RxString musicSource = "".obs;
  RxString audioPosition = "".obs;
  RxString audioTotal = "".obs;
  RxString isPlaying = "stop".obs;
  RxInt playerID = 0.obs;
  RxBool isConnect = false.obs;
  RxList texts = [].obs;
  RxString chatStatus = "".obs;
  RxMap<int, dynamic> myChatList = <int, dynamic>{}.obs;
  RxList<ConsultantsModel> consultants = <ConsultantsModel>[].obs;
  RxList<SpecialistsModel> specialists = <SpecialistsModel>[].obs;
  RxList<SpecialistsModel> myspecialists = <SpecialistsModel>[].obs;
  RxList consultantsMessages = [].obs;

  RxList chats = [].obs;
  RxInt lastChat = 0.obs;
  RxBool voiceAnimate = false.obs;
  RxBool lastChatLoading = false.obs;
  RxBool moreChatLoading = false.obs;

  RxInt star = 1.obs;

  RxList messageClose = [].obs;

  RxMap<int, dynamic> chatList = <int, dynamic>{}.obs;

  IO.Socket socket = IO.io('https://api.salamatiman.ir:4000', <String, dynamic>{
    "transports": ["websocket"],
    "autoConnect": true,
  });

  Rx<ScrollController> chatScrollController = ScrollController().obs;

  RxInt myChatId = 0.obs;
  RxInt myChatPage = 1.obs;
  RxInt myChatTotalPage = 1.obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await socketIOConfig();
    await getSpecialists();
    await getConsultants();
    chatScrollController(ScrollController()..addListener(_scrollListener));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    chatScrollController.value.dispose();
  }

  socketIOConfig() {
    //connect
    socket.on('connect', (mySocket) {
      isConnect(true);
    });

    socket.on('talk-close', (data) {
      print("چت بسته شد");
      if (!messageClose.contains(data["tid"])) {
        messageClose.add(data["tid"]);
      }
      Get.dialog(
        Obx(() {
          final myStar = star;
          return AlertDialog(
            title: Text(
              "چت پایان یافت",
              style: TextStyle(fontSize: 20.sp),
            ),
            content: SizedBox(
              height: 140.sp,
              width: Get.width * 0.95,
              child: Column(
                children: [
                  Text(
                    "لطفا به ${data["name"]} امتیاز دهید",
                    style: TextStyle(
                      fontSize: 18.sp,
                    ),
                  ),
                  SizedBox(height: 15.sp),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (var i = 1; i < 6; i++) ...[
                        GestureDetector(
                          onTap: () {
                            print(i);
                            star(i);
                          },
                          child: star.value == i
                              ? Image.asset(
                                  "assets/images/ratting/ratting-${i}.png",
                                  width: 40.sp,
                                )
                              : Container(
                                  foregroundDecoration: BoxDecoration(
                                    color: Colors.grey,
                                    backgroundBlendMode: BlendMode.saturation,
                                  ),
                                  child: Image.asset(
                                    "assets/images/ratting/ratting-${i}.png",
                                    width: 40.sp,
                                  ),
                                ),
                        ),
                      ],
                    ],
                  )
                ],
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  Get.back();
                  setChatRating(tid: data["tid"], rating: star.value);
                },
                child: Text("ثبت امتیاز",
                    style: TextStyle(color: Constants.primaryColor2)),
              ),
            ],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.sp))),
          );
        }),
      );
    });

    socket.on('talk-open', (data) {
      if (messageClose.contains(data["tid"])) {
        messageClose.remove(data["tid"]);
      }
    });

    socket.on('new message', (data) async {
      lastChat(data["tid"]);
      if (chatList.keys.contains(data["tid"])) {
        List list1 = chatList[data["tid"]];
        list1.add(data);
        chatList[data["tid"]] = list1;
      } else {
        chatList.addAll({
          data["tid"]: [data]
        });
        //lastChat(data["tid"]);
        getConsultants();
      }
    });

    socket.on('user left', (data) async {
      chats.add(data);
      print("user left $data");
    });

    socket.on('removeMessage', (data) {
      List myChats = chatList[data["tid"]];
      myChats.removeWhere((item) => item['id'] == data["id"]);
      chatList[data["tid"]] = myChats;
    });

    socket.on('disconnect', (_) {
      print('disconnect');
      isConnect(false);
    });
  }

  setAuth({expertID}) {
    socket.emit("authenticate", {
      "token": GetStorage().read('UserToken'),
      "room": expertID.uid.toString() +
          "_" +
          GetStorage().read('UserInfo')['id'].toString(),
    });
  }

  setChatRating({required rating, required tid}) async {
    print(rating);
    print(tid);
    final res = await ChatServer().setChatRating(rating: rating, tid: tid);
    print(res);
    if (res is Failure) {
      print(res.errorResponse);
    }
  }

  //لیست متخصص ها
  getSpecialists() async {
    loading.value = true;
    var res = await ChatServer().getSpecialists();
    if (res is Success) {
      var json = jsonDecode(res.response.toString());
      json
          .map((item) => specialists.add(SpecialistsModel.fromJson(item)))
          .toList();
      loading.value = false;
    }
    loading.value = false;
  }

  //لیست متخصص های من
  getMySpecialists() async {
    loading.value = true;
    if (myspecialists.isEmpty) {
      var res = await ChatServer().getMySpecialists();
      if (res is Success) {
        var json = jsonDecode(res.response.toString());
        json
            .map((item) => myspecialists.add(SpecialistsModel.fromJson(item)))
            .toList();
        loading.value = false;
      }
    }

    loading.value = false;
  }

  //لیست کسایی که چت کزدم
  getConsultants() async {
    loading.value = true;
    var res = await ChatServer().getConsultants();
    if (res is Success) {
      var json = jsonDecode(res.response.toString());
      json
          .map((item) => consultants.add(ConsultantsModel.fromJson(item)))
          .toList();
      loading.value = false;
    } else if (res is Failure) {
      print(res.errorResponse);
    }
    loading.value = false;
  }

  //دریافت لیست چت ها
  getConsultantsMessages(
      {required chatID, required int page, hasMoreLoading = false}) async {
    if (hasMoreLoading) {
      moreChatLoading(true);
    } else {
      lastChatLoading(true);
      consultantsMessages.value = [];
    }

    if (chatList.keys.contains(chatID)) {
      if (!hasMoreLoading) {
        chatList[chatID] = [];
      }
    } else {
      chatList.addAll({chatID: []});
    }
    var res =
        await ChatServer().getConsultantMessages(chatID: chatID, page: page);
    if (res is Success) {
      if ("no results found" != res.response) {
        myChatId.value = chatID;
        myChatPage.value = page + 1;
        var json = jsonDecode(res.response.toString());
        myChatTotalPage.value = json["messages"]["pages"];
        if (json["talk"]["status"] == "closed") {
          if (!messageClose.contains(int.parse(chatID.toString()))) {
            messageClose.add(int.parse(chatID.toString()));
          }
        } else {
          if (messageClose.contains(int.parse(chatID.toString()))) {
            messageClose.remove(int.parse(chatID.toString()));
          }
        }
        chatStatus(json["talk"]["status"]);
        List userChats = [];
        json["messages"]["docs"].map((item) => userChats.add(item)).toList();
        if (consultantsMessages.isEmpty) {
          consultantsMessages.addAll(userChats);
        } else {
          consultantsMessages.insert(0, userChats[0]);
        }

        if (chatList.keys.contains(chatID)) {
          chatList[chatID] = consultantsMessages;
        } else {
          chatList.addAll({chatID: consultantsMessages});
        }
      }
      lastChatLoading(false);
    } else if (res is Failure) {
      if (kDebugMode) {
        print(res.errorResponse);
      }
    }
    lastChatLoading(false);
    moreChatLoading(false);
    //GetStorage().write('historyChatList', chatList);
    update();
  }

  void _scrollListener() {
    if (chatScrollController.value.position.extentAfter < 12) {
      if (myChatPage.value < myChatTotalPage.value) {
        getConsultantsMessages(
          page: myChatPage.value,
          chatID: myChatId.value,
          hasMoreLoading: true,
        );
      }
    }
  }

  Future<bool> removeMessage(
      {required id, required indexOf, required chatID}) async {
    List myChats = chatList[chatID];
    socket.emit("removeMessage", id);
    return await true;
  }

  sendMessage(
      {required chatID,
      required to,
      required String type,
      required String text}) {
    final data = {
      "tid": chatID,
      "to": to,
      "content_type": type,
      "content": text,
      "from_expert": false,
    };
    print(data);
    socket.emit("new message", data);
  }

  sendMessageFile(
      {required chatID,
      required to,
      required String type,
      required image,
      required fileName}) {
    final data = {
      "tid": chatID,
      "to": to,
      "content_type": type,
      "content": image,
      "from_expert": false,
      "file_name": fileName,
    };
    socket.emit("new message", data);
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  initPlay() async {
    if (musicSource.value != "") {
      try {
        await audioPlayer.setFilePath('${musicSource.value}');
        play();
      } catch (e) {
        print(e);
      }
    }
  }

  networkPlay({file}) async {
    try {
      var uri = Uri.parse("https://${Constants.BaseUrl}" + file.toString());
      await audioPlayer.setAudioSource(AudioSource.uri(uri));
      audioPlayer.play();
    } catch (e) {}
  }

  play() {
    audioPlayer.play();
    durationStream();
    positionStream();
    isPlaying("play");
  }

  stop() {
    if (audioPlayer.playing) {
      audioPlayer.stop();
      isPlaying("stop");
    }
  }

  pause() {
    if (audioPlayer.playing) {
      audioPlayer.pause();
      isPlaying("pause");
    }
  }

  seek({required position}) {
    audioPlayer.seek(position);
  }

  positionStream() {
    audioPlayer.positionStream.listen((event) {
      audioPosition(event.toString());
    });
    audioPlayer.playingStream.listen((event) {
      if (event) {
        isPlaying("play");
      } else {
        isPlaying("pause");
      }
    });
    audioPlayer.processingStateStream.listen((ProcessingState event) {
      if (event == ProcessingState.completed) {
        isPlaying("stop");
      }
    });
  }

  durationStream() {
    audioPlayer.durationStream.listen((event) {
      audioTotal(event.toString());
    });
  }

  void scrollToBottom() {
    final bottomOffset = chatScrollController.value.position.maxScrollExtent;
    chatScrollController.value.animateTo(
      bottomOffset,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
    );
  }

// Future record() async {
//   Directory appDocDirectory = await getApplicationDocumentsDirectory();
//   new Directory(appDocDirectory.path + '/' + 'dir')
//       .create(recursive: true)
//       .then((Directory directory) async {
//     await recorder.startRecorder(
//       toFile: '${directory.path}/temp.wav',
//       codec: Codec.pcm16WAV,
//     );
//   });
// }
//
// Future stopRecord({chatID, user}) async {
//   final path = await recorder.stopRecorder();
//   Directory appDocDirectory = await getApplicationDocumentsDirectory();
//   final file = File(appDocDirectory.path + "/dir/temp.wav");
//   sendMessageFile(
//       image: await file.readAsBytes(),
//       type: "music",
//       chatID: chatID,
//       to: user.uid,
//       fileName: "audio.wav");
// }
//
// Future initRecorder() async {
//   final status = Permission.microphone.request();
//   if (Permission.microphone.status.isDenied == true) {
//     await openAppSettings();
//   } else {
//     await recorder.openRecorder();
//     await record();
//     recorder.setSubscriptionDuration(
//       const Duration(milliseconds: 500),
//     );
//   }
// }
}
