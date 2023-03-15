import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:salamatiman/getx/notes/notes.dart';
import 'package:salamatiman/model/notes/notes-model.dart';
import 'package:salamatiman/utils/constants.dart';

class NoteEdit extends GetView<NotesGetter> {
  final NotesModel note;
  TextEditingController? _TextEditingController;
  String? backupText;

  NoteEdit({Key? key, required this.note}) : super(key: key) {
    _TextEditingController =
        TextEditingController(text: note.description.toString());
    controller.myText.value = "";
    if (note.description.toString().length > 0) {
      changeRtl(note.description.toString());
      controller.myText.value = note.description.toString();
      backupText = note.description.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Constants.primaryColor,
        backgroundColor: Constants.primaryColor,
        actions: [
          Obx(() {
            final isChange = backupText == controller.myText.value;
            if (isChange) {
              return Text("");
            }
            return IconButton(
                onPressed: () async {
                  var res = await controller.updateNote(
                      noteID: note.id, content: controller.myText.value);
                  if (res) {
                    Get.back();
                    Fluttertoast.showToast(msg: "یادداشت شما ذخیره شد");
                  } else {
                    Fluttertoast.showToast(msg: "خطا در ذخیره سازی");
                  }
                },
                icon: Icon(
                  Icons.check,
                  color: Constants.successColor,
                ));
          })
        ],
      ),
      body: Obx(() {
        final myText = controller.myText.value;
        final isChange = backupText == controller.myText.value;
        return WillPopScope(
          onWillPop: () async {
            if (isChange == false) {
              return Future.value(await showCupertinoModalPopup(
                context: context,
                builder: (BuildContext context) {
                  return CupertinoAlertDialog(
                    title: const Text(
                      'ذخیره سازی',
                      style: TextStyle(fontFamily: "vazir"),
                    ),
                    content: const Text(
                      'یادداشت شما تغییر کرده . نمیخواهید ذخیره کنید',
                      style: TextStyle(fontFamily: "vazir"),
                    ),
                    actions: <CupertinoDialogAction>[
                      CupertinoDialogAction(
                        isDefaultAction: false,
                        onPressed: () {
                          Get.back();
                          Get.back();
                        },
                        child: const Text(
                          'نه',
                          style: TextStyle(fontFamily: "vazir"),
                        ),
                      ),
                      CupertinoDialogAction(
                        isDefaultAction: true,
                        onPressed: () async {
                          Get.back();
                          var res = await controller.updateNote(
                              noteID: note.id,
                              content: controller.myText.value);
                          if (res) {
                            Get.back();
                            Fluttertoast.showToast(msg: "یادداشت شما ذخیره شد");
                          } else {
                            Fluttertoast.showToast(msg: "خطا در ذخیره سازی");
                          }
                        },
                        child: const Text('ذخیره'),
                      ),
                    ],
                  );
                },
              ));
            }
            return Future.value(true);
          },
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(Get.width * 0.03),
              child: Column(
                children: [
                  Expanded(
                    child: TextFormField(
                      textAlign: controller.textDirectionisRight.value
                          ? TextAlign.right
                          : TextAlign.left,
                      textDirection: controller.textDirectionisRight.value
                          ? TextDirection.rtl
                          : TextDirection.ltr,
                      controller: _TextEditingController,
                      textInputAction: TextInputAction.newline,
                      keyboardType: TextInputType.multiline,
                      minLines: null,
                      maxLines: null,
                      expands: true,
                      maxLength: 250,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          counterText:
                              'تعداد کاراکتر باقی مانده ${(250 - myText.length)}'),
                      onChanged: (val) {
                        controller.myText.value = val;
                        if (val.length > 0) changeRtl(val);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  changeRtl(val) {
    final isChange = backupText == controller.myText.value;
    if (isChange) {
      controller.isSaved.value = false;
    } else {
      controller.isSaved.value = true;
    }
    RegExp exp = RegExp("[a-zA-Z]");
    if (exp.hasMatch(val.substring(val.length - 1)) &&
        val.substring(val.length - 1) != " ") {
      controller.textDirectionisRight.value = false;
    } else if (val.substring(val.length - 1) != " " &&
        !exp.hasMatch(val.substring(val.length - 1))) {
      controller.textDirectionisRight.value = true;
    }
  }
}
