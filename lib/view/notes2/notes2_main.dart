import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:salamatiman/utils/constants.dart';
import 'package:salamatiman/widgets/select-date/select-date.dart';

import '../../getx/notes/notes.dart';

class Notes2Main extends GetView<NotesGetter> {
  Notes2Main({Key? key}) : super(key: key) {
    Get.put(NotesGetter());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.isSaved(true);
      controller.getNotesByDate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        surfaceTintColor: Constants.primaryColor,
        automaticallyImplyLeading: true,
        toolbarHeight: 70,
        centerTitle: true,
        title: WidgetSelectDateHome(
            filed: controller.dateSelected,
            afterChange: Get.find<NotesGetter>()),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Obx(() {
                final myText = controller.myText.value;
                final isSaved = controller.isSaved.value;
                final Color saveColor = myText.isNotEmpty && isSaved == false
                    ? Constants.secondaryColor
                    : Colors.grey.shade500;
                return GestureDetector(
                  onTap: myText.isNotEmpty && isSaved == false
                      ? () async {
                          if (controller.notes.isNotEmpty) {
                            final note = controller.notes;
                            final res = await controller.updateNote(
                                noteID: note[0].id, content: myText);
                            if (res) {
                              controller.isSaved(true);
                              Fluttertoast.showToast(
                                  msg: "یادداشت شما ذخیره شد");
                            } else {
                              Fluttertoast.showToast(msg: "خطا در ذخیره سازی");
                            }
                          } else if (myText.isNotEmpty) {
                            final res = await controller.setNewNote(
                                content: controller.myText.value);
                            if (res) {
                              controller.isSaved(true);
                              Fluttertoast.showToast(
                                  msg: "یادداشت شما ذخیره شد");
                            } else {
                              Fluttertoast.showToast(msg: "خطا در ذخیره سازی");
                            }
                          }
                        }
                      : null,
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.center,
                    children: [
                      Icon(Icons.check, color: saveColor),
                      Text(
                        "ذخیره",
                        style: TextStyle(color: saveColor),
                      ),
                    ],
                  ),
                );
              }),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey.shade300),
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Obx(() {
            final myText = controller.myText.value;
            return Directionality(
              textDirection: TextDirection.ltr,
              child: TextFormField(
                textAlign: controller.textDirectionisRight.value
                    ? TextAlign.right
                    : TextAlign.left,
                textDirection: controller.textDirectionisRight.value
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                controller: controller.textEditingController.value,
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.multiline,
                maxLength: 250,
                maxLines: 7,
                minLines: 7,
                decoration: InputDecoration(
                  hintText: "یادداشتتو بنویس",
                  border: InputBorder.none,
                  counterText:
                      'تعداد کاراکتر باقی مانده ${(250 - myText.length)}',
                  counterStyle: TextStyle(color: Colors.grey.shade500),
                  isDense: true,
                  hintStyle: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.grey.shade500,
                  ),
                  contentPadding: EdgeInsets.all(5),
                ),
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey.shade700,
                ),
                onChanged: (val) {
                  controller.myText(val);
                  if (controller.notes.isNotEmpty) {
                    if (val.toString() ==
                        controller.notes[0].description.toString()) {
                      controller.isSaved.value = true;
                    } else {
                      controller.isSaved.value = false;
                    }
                  } else {
                    if (val.isNotEmpty) {
                      controller.isSaved.value = false;
                    } else {
                      controller.isSaved.value = true;
                    }
                  }

                  if (val.isNotEmpty) {
                    changeRtl(val.toString());
                  }
                },
              ),
            );
          }),
        ),
      ),
    );
  }

  changeRtl(val) {
    RegExp exp = RegExp("[a-zA-Z]");
    if (exp.hasMatch(val.substring(val.length - 1)) &&
        val.substring(val.length - 1) != " ") {
      controller.textDirectionisRight(false);
    } else if (val.substring(val.length - 1) != " " &&
        !exp.hasMatch(val.substring(val.length - 1))) {
      controller.textDirectionisRight(true);
    }
  }
}
