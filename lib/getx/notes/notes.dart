import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:salamatiman/model/notes/notes-model.dart';
import 'package:salamatiman/repo/api-status.dart';
import 'package:salamatiman/service/notes/notes-service.dart';
import 'package:salamatiman/utils/get-date.dart';

class NotesGetter extends GetxController {
  RxList<NotesModel> notes = <NotesModel>[].obs;
  RxBool loading = false.obs;
  RxBool textDirectionisRight = true.obs;

  RxString myText = "".obs;
  RxBool isSaved = true.obs;

  RxList<int> listForDelete = <int>[].obs;

  RxList searchResult = [].obs;
  RxString searchText = "".obs;

  RxString dateSelected = GetDate.todayOnlyDate().toString().obs;

  Rx<TextEditingController> textEditingController =
      TextEditingController(text: "").obs;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //searchTextController.dispose();
  }

  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getNotes();
  }

  txtController({required value}) {
    textEditingController(TextEditingController(text: value.toString()));
    update();
  }

  getNotes() async {
    loading.value = true;
    notes.value = [];
    try {
      var res = await NotesService().getNotes();
      if (res is Success) {
        var json = jsonDecode(res.response.toString());
        if (json.length > 0) {
          json.map((item) => notes.add(NotesModel.fromJson(item))).toList();
        }
      }
    } catch (e) {
      print(e);
    }
    loading.value = false;
  }

  setNewNote({required String? content}) async {
    loading.value = true;
    try {
      var res = await NotesService().setNewNote(content: content);
      if (res is Success) {
        await getNotes();
        return true;
      }
    } catch (e) {
      print(e);
    }
    loading.value = false;
    return false;
  }

  updateNote({required String? content, required noteID}) async {
    loading.value = true;
    try {
      var res =
          await NotesService().updateNote(content: content, noteID: noteID);
      if (res is Success) {
        await getNotes();
        return true;
      }
    } catch (e) {
      print(e);
    }
    loading.value = false;
    return false;
  }

  deleteNote() async {
    if (listForDelete.isNotEmpty) {
      loading.value = true;
      try {
        var res = await NotesService().deleteNote(listDelete: listForDelete);
        if (res is Success) {
          await getNotes();
          if (listForDelete.length > 1) {
            Fluttertoast.showToast(msg: "یادداشت های شما با موفقیت حذف شد");
          } else {
            Fluttertoast.showToast(msg: "یادداشت شما با موفقیت حذف شد");
          }
          await getNotes();
        } else {
          Fluttertoast.showToast(msg: "خطا در حذف کردن");
        }
        listForDelete([]);
      } catch (e) {
        print(e);
      }
      loading.value = false;
      return false;
    }
    return false;
  }

  getNotesByDate() async {
    try {
      notes([]);
      final res = await NotesService().getNotesByDate(date: dateSelected.value);
      if (res is Success) {
        final json = jsonDecode(res.response.toString());
        if (json.isNotEmpty) {
          myText(json[0]["description"]);
          json.map((item) => notes.add(NotesModel.fromJson(item))).toList();
        } else {
          myText("");
        }
      } else {
        myText("");
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    txtController(value: myText.toString());
  }

  getDataByDate([date]) async {
    if (date != null) {
      dateSelected(date.toString().split(" ")[0].toString());
    }
    await getNotesByDate();
  }
}
