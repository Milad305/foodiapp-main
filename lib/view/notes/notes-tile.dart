import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:salamatiman/getx/notes/notes.dart';
import 'package:salamatiman/model/notes/notes-model.dart';

import 'note-edit.dart';

class NotesTile extends GetView<NotesGetter> {
  final NotesModel note;

  const NotesTile({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GestureDetector(
        onLongPress: () {
          if (controller.listForDelete.isEmpty) {
            controller.listForDelete.add(int.parse(note.id.toString()));
          } else {
            if (controller.listForDelete
                .contains(int.parse(note.id.toString()))) {
              controller.listForDelete.remove(int.parse(note.id.toString()));
            } else {
              controller.listForDelete.add(int.parse(note.id.toString()));
            }
          }
        },
        onTap: () {
          if (controller.listForDelete.isEmpty) {
            Get.to(() => NoteEdit(note: note),
                transition: Transition.leftToRight);
          } else {
            if (controller.listForDelete
                .contains(int.parse(note.id.toString()))) {
              controller.listForDelete.remove(int.parse(note.id.toString()));
            } else {
              controller.listForDelete.add(int.parse(note.id.toString()));
            }
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: controller.listForDelete.contains(note.id)
                ? Colors.red.shade100
                : Colors.white,
            borderRadius: BorderRadius.circular(7),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.only(top: 5),
                width: double.infinity,
                child: Text(
                  note.description.toString(),
                  maxLines: 7,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  note.date.toString().toPersianDate(),
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
