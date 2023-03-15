import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:salamatiman/getx/food/recipes.dart';
import 'package:salamatiman/utils/constants.dart';
import 'package:salamatiman/view/food/custom-recipes/widgets/recipes-tile.dart';

class ServWidget extends GetView<RecipesGetter> {
  ServWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Obx(() {
        final servType = controller.servType.value;
        final rows = <TableRow>[];
        final defaultFormValue = controller.defaultFormValue;
        rows.add(
          TableRow(children: [
          Padding(
            padding: EdgeInsets.only(right: 7.sp),
            child: Text('مقیاس', style: TextStyle(fontSize: 14.0.sp)),
          ),
          Center(
            child: Text(servType == 0 ? 'میزان در سرو' : 'گرم',
                style: TextStyle(fontSize: 14.sp)),
          ),
          Container(),
        ]));
        for (int i = 0; i < defaultFormValue.length; i++) {
          rows.add(
            TableRow(

              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.grey.shade300,
                    width: 1.sp,
                  ),
                  bottom: BorderSide(
                    color: Colors.grey.shade300,
                    width: 1.sp,
                  ),
                ),
              ),
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                  child: CustomInputForLoop(
                      val: defaultFormValue[i]["title"],
                      index: i,
                      servType: servType,
                      type: "title"),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                  child: CustomInputForLoop(
                      val: defaultFormValue[i]["size"],
                      index: i,
                      servType: servType,
                      type: "size"),
                ),
                Transform.scale(
                  scale: 0.65,
                  filterQuality: FilterQuality.none,
                  child: IconButton(
                    onPressed: () {
                      controller.defaultFormValue
                          .remove(controller.defaultFormValue[i]);
                    },
                    icon: Icon(
                      Icons.delete_rounded,
                      color: Colors.redAccent,
                      size: 30.sp,
                    ),
                  ),
                ),
              ]));
        }

        return Table(
          border: const TableBorder(
            bottom: BorderSide.none,
          ),
          columnWidths: const <int, TableColumnWidth>{
            1: FlexColumnWidth(),
            2: FixedColumnWidth(100),
            3: FixedColumnWidth(350),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          textBaseline: TextBaseline.ideographic,
          children: rows,
        );
      }),
    );
  }

  Widget CustomInputForLoop(
      {required val, required index, required servType, required type}) {
    return TextFormField(
      textDirection: TextDirection.rtl,
      keyboardType: type == "size" ? TextInputType.number : TextInputType.text,
      cursorHeight: 20,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(5.sp),
        border: InputBorder.none,
      ),
      textAlign: type == 'title' ? TextAlign.start : TextAlign.center,
      style: TextStyle(
        fontSize: 12.sp,
        color: Constants.textColor,
        fontFamily: Constants.primaryFontFamilyAdad),
      controller: TextEditingController(text: val),
      onChanged: (val) {
        if (val.toString().isNotEmpty) {
          final myList = controller.defaultFormValue;
          myList[index][type] = val.toString();
        }
      },
    );
  }
}
