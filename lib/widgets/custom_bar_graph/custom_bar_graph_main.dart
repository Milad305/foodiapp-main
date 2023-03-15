import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../../utils/constants.dart';
import 'custom_bar_graph_data_class.dart';

class CustomBarGraphMain extends StatefulWidget {
  final double? height;
  final List<CustomBarGraphData>? data;
  final Color? barColor;
  final Color? activeBgColor;
  final Color? activeTextColor;
  final Color? itemBgColor;
  final Color? itemTextColor;
  final Color? bgRowColor;
  final int? initialItem;
  final double? itemExtent;
  FixedExtentScrollController _controller = FixedExtentScrollController();
  CustomBarGraphMain({
    Key? key,
    this.height = 300,
    required this.data,
    this.barColor = Colors.green,
    this.itemBgColor = Colors.transparent,
    this.itemTextColor = Colors.black,
    this.activeBgColor = Colors.black,
    this.activeTextColor = Colors.white,
    this.bgRowColor = Colors.grey,
    this.initialItem = 5,
    this.itemExtent = 35,
  }) : super(key: key) {
    _controller = FixedExtentScrollController(initialItem: initialItem! - 1);
  }

  @override
  State<CustomBarGraphMain> createState() =>
      _CustomBarGraphMainState(initialItem! - 1);
}

class _CustomBarGraphMainState extends State<CustomBarGraphMain> {
  int? initialItem;
  _CustomBarGraphMainState(this.initialItem);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: double.infinity,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: widget.height!,
            alignment: Alignment.bottomCenter,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  width: double.infinity,
                  height: widget.itemExtent!,
                  decoration: BoxDecoration(
                    color: widget.bgRowColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                Container(
                  width: widget.itemExtent,
                  height: widget.itemExtent,
                  decoration: BoxDecoration(
                      color: widget.activeBgColor,
                      borderRadius: BorderRadius.circular(50)),
                ),
                Container(
                  height: widget.height,
                  alignment: Alignment.bottomCenter,
                  child: RotatedBox(
                    quarterTurns: -1,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 4.sp),
                      alignment: Alignment.bottomCenter,
                      child: ListWheelScrollView.useDelegate(
                          itemExtent: widget.itemExtent!,
                          controller: widget._controller,
                          physics: FixedExtentScrollPhysics(),
                          renderChildrenOutsideViewport: false,
                          diameterRatio: 100,
                          onSelectedItemChanged: (val) {
                            setState(() {
                              initialItem = val;
                            });
                          },
                          childDelegate: ListWheelChildBuilderDelegate(
                            childCount: widget.data!.length,
                            builder: (context, index) {
                              final itemData = widget.data![index];
                              //percentage
                              final dItemExtent =
                                  double.parse(widget.itemExtent.toString());
                              final dWidget =
                                  double.parse(widget.height.toString());
                              final maxPercentage =
                                  ((dWidget / 3) - dItemExtent);
                              final itemHeight = (maxPercentage *
                                      double.parse(
                                          itemData.percentage.toString())) /
                                  100;
                              return Container(
                                width: dWidget,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Spacer(),
                                    Container(
                                      width: itemHeight > 0
                                          ? (itemHeight * 2).sp > 9.sp
                                              ? (itemHeight * 2).sp
                                              : 9.sp
                                          : 9.sp,
                                      height: 9.sp,
                                      decoration: BoxDecoration(
                                          color: widget.barColor,
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                    ),
                                    RotatedBox(
                                      quarterTurns: 1,
                                      child: _ItemBuilder(
                                        item: itemData.date
                                            .toString()
                                            .split("/")[2],
                                        index: index,
                                        height: widget.height,
                                        itemExtent: widget.itemExtent,
                                        itemActive: initialItem,
                                        itemColor: widget.itemBgColor,
                                        itemTextColor: widget.itemTextColor,
                                        activeBgColor: widget.activeBgColor,
                                        activeTextColor: widget.activeTextColor,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          )),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  top: (double.parse(widget.height.toString()) / 2) -
                      double.parse(widget.itemExtent.toString()),
                  child: Container(
                    width: Get.width,
                    height: 50,
                    alignment: Alignment.center,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          child: Text(
                            "------------------------------------------------------------------------------------------------------------------------------",
                            maxLines: 1,
                            style: TextStyle(color: Colors.grey.shade400),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 2),
                            decoration: BoxDecoration(
                              color: Constants.secondaryColor,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(
                              "هدف",
                              style: TextStyle(
                                color: Constants.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _ItemBuilder({
    required item,
    required index,
    required height,
    required itemExtent,
    required itemActive,
    required itemColor,
    required itemTextColor,
    required activeBgColor,
    required activeTextColor,
  }) {
    return Container(
      width: itemExtent,
      height: itemExtent,
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 8.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
      ),
      child: Text(
        item.toString().toPersianDigit(),
        style: TextStyle(
          color: itemActive == index ? activeTextColor : itemTextColor,
          fontSize: 17.sp,
          textBaseline: TextBaseline.ideographic,
        ),
      ),
    );
  }
}
