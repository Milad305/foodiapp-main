import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salamatiman/getx/chat/chat-getter.dart';
import 'package:salamatiman/utils/constants.dart';

class AudioTile extends GetView<ChatGetter> {
  final bool forMe;
  final file;
  const AudioTile({Key? key, required this.forMe, required this.file})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: forMe ? Alignment.centerRight : Alignment.centerLeft,
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.only(left: forMe ? 20 : 0, right: forMe ? 0 : 20),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: forMe ? Color(0xFFE6E6E9) : Color(0xFF2D35DC),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(forMe ? 13 : 0),
            topLeft: Radius.circular(13),
            bottomRight: Radius.circular(forMe ? 0 : 13),
            topRight: Radius.circular(13),
          ),
        ),
        child: Container(
          child: Obx(() {
            final play = controller.isPlaying.value;
            var progress = Duration(seconds: 0);
            var total = Duration(seconds: 0);
            final isThisPlayer = controller.playerID.value == file["id"];
            try {
              if (controller.audioPosition.value.isNotEmpty &&
                  controller.audioTotal.value.isNotEmpty) {
                progress = controller.audioPosition.value != null
                    ? Constants.parseDuration(
                        controller.audioPosition.value.toString())
                    : Duration(seconds: 0);
                total = controller.audioTotal.value != null
                    ? Constants.parseDuration(
                        controller.audioTotal.value.toString())
                    : Duration(seconds: 0);
              }
            } catch (e) {}

            if (!isThisPlayer) {
              total = Duration(seconds: 0);
              progress = Duration(seconds: 0);
            }

            return Container(
              width: Get.width * 0.7,
              alignment: Alignment.centerLeft,
              child: Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: (Get.width * 0.7) - 80,
                    child: ProgressBar(
                      progress: progress,
                      buffered: total,
                      total: total,
                      onSeek: (duration) {
                        if (total != Duration(seconds: 0)) {
                          controller.seek(position: duration);
                        }
                      },
                      timeLabelTextStyle: TextStyle(
                        fontFamily: Constants.primaryFontFamilyAdad,
                        fontSize: 17,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: IconButton(
                      icon: !isThisPlayer
                          ? Icon(
                              Icons.music_note_outlined,
                              color: Colors.white,
                              size: 30,
                            )
                          : Icon(
                              controller.isPlaying.value == "stop"
                                  ? Icons.music_note_outlined
                                  : controller.audioPlayer.playing
                                      ? Icons.pause
                                      : Icons.play_arrow,
                              color: Colors.white,
                              size: 30,
                            ),
                      onPressed: () {
                        controller.playerID(file['id']);
                        try {
                          if (file["content"] != null) if (controller
                              .audioPlayer.playing) {
                            controller.pause();
                          } else if (controller.isPlaying.value == "pause") {
                            controller.networkPlay(file: file["content"]);
                            controller.play();
                          } else {
                            controller.networkPlay(file: file["content"]);
                            controller.play();
                          }
                        } catch (e) {}
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
