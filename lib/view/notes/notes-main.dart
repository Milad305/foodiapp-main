import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:salamatiman/getx/notes/notes.dart';
import 'package:salamatiman/utils/constants.dart';
import 'package:salamatiman/view/notes/notes-tile.dart';

import 'note-insert.dart';

class NotesMain extends GetView<NotesGetter> {
  NotesMain({Key? key}) : super(key: key) {
    Get.put(NotesGetter());
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController searchTextController = TextEditingController();
    searchTextController.selection = TextSelection.fromPosition(
        TextPosition(offset: searchTextController.text.length));
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              leading: GestureDetector(
                child: Icon(Icons.close),
                onTap: () => Get.back(),
              ),
              surfaceTintColor: Constants.primaryColor,
              backgroundColor: Constants.primaryColor,
              title: const Text("یادداشت‌ها"),
              actions: [
                Obx(() => controller.listForDelete.isEmpty
                    ? Text("")
                    : IconButton(
                        icon: Icon(Icons.checklist_rtl_outlined),
                        onPressed: () {
                          if (controller.listForDelete.length <
                              controller.notes.length) {
                            controller.notes
                                .map((note) =>
                                    !controller.listForDelete.contains(note.id)
                                        ? controller.listForDelete
                                            .add(int.parse(note.id.toString()))
                                        : "")
                                .toList();
                          } else {
                            controller.listForDelete([]);
                          }
                        },
                      )),
                Obx(() => controller.listForDelete.isEmpty
                    ? Text("")
                    : IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          controller.deleteNote();
                        },
                      )),
              ],
              centerTitle: true,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(80.0),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
                  margin: EdgeInsets.only(bottom: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        controller: searchTextController,
                        onTap: () {
                          searchTextController.selection =
                              TextSelection.fromPosition(TextPosition(
                                  offset: searchTextController.text.length));
                        },
                        decoration: InputDecoration(
                          icon: const Icon(Icons.search),
                          border: InputBorder.none,
                          hintText: "جستجوی یادداشت ها",
                          hintStyle: TextStyle(color: Colors.grey.shade500),
                          suffixIcon: Obx(() {
                            final searchText = controller.searchText.value;
                            return searchText.length > 0
                                ? IconButton(
                                    onPressed: () {
                                      controller.searchResult([]);
                                      controller.searchText.value;
                                      controller.searchText("");
                                      searchTextController.clear();
                                    },
                                    icon: Icon(Icons.clear),
                                  )
                                : Text("");
                          }),
                        ),
                        onChanged: (val) {
                          controller.searchText(val);

                          if (val.length > 1) {
                            search(val);
                          } else {
                            controller.searchResult([]);
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ];
        },
        floatHeaderSlivers: false,
        body: Obx(() {
          final loading = controller.loading.value;
          final notes = controller.notes.value;
          final reverseNotes = controller.searchResult.isEmpty &&
                  controller.searchText.value == ""
              ? notes.reversed.toList()
              : controller.searchResult.value;

          return loading
              ? LoadingWidget()
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: StaggeredGrid.count(
                            crossAxisCount: 1,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            children: reverseNotes
                                .map((note) => NotesTile(
                                      note: note,
                                    ))
                                .toList(),
                          ),
                        ),
                      )
                    ],
                  ),
                );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "addNowNote",
        onPressed: () => Get.to(() => NoteInsert()),
        child: const Icon(Icons.add),
        tooltip: "افزون یادداشت",
      ),
    );
  }

  Widget LoadingWidget() {
    return const Center(
      child: const SpinKitThreeBounce(
        color: Colors.black45,
        size: 17,
      ),
    );
  }

  void search(text) {
    final notes = controller.notes.value;
    final reverseNotes = notes.reversed.toList();
    controller.searchResult(reverseNotes
        .where((note) => note.description
            .toString()
            .toLowerCase()
            .contains(text.toLowerCase()))
        .toList());
  }
}
