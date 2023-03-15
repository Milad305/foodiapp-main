import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:salamatiman/model/sport/sport-model.dart';

import '../../getx/sport/sport-getter.dart';
import '../../utils/constants.dart';
import 'add_record.dart';

class SearchSport extends GetView<SportGetter> {
  SearchSport({Key? key}) : super(key: key) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.sportSearch([]);
    });
  }

  List defaultSports = [
    {
      "id": 8,
      "met": 7.5,
      "title": "دوچرخه سواری",
      "description": "دوچرخه سواری معمولی",
      "steps": null,
      "img": "https:\/\/cdn.salamatiman.ir\/images\/exercises\/8.jpg",
      "images": "https:\/\/cdn.salamatiman.ir\/images\/exercises\/8.jpg",
      "show_to_user": null,
      "video": null,
      "category": 1,
      "minutes": 30,
      "difficulty": null,
      "uid": null
    },
    {
      "id": 680,
      "met": 3.5,
      "title": "پیاده روی",
      "description":
          "پیاده روی در زمین صاف یا سفت با سرعت متوسط 4.5 تا 5 کیلومتر در ساعت ",
      "steps": null,
      "img": "https:\/\/cdn.salamatiman.ir\/images\/exercises\/680.jpg",
      "images": "https:\/\/cdn.salamatiman.ir\/images\/exercises\/680.jpg",
      "show_to_user": null,
      "video": null,
      "category": 17,
      "minutes": 30,
      "difficulty": null,
      "uid": null
    },
    {
      "id": 124,
      "met": 2.3,
      "title": "فعالیت های خانگی",
      "description": "جارو کردن آهسته و با تحرک کم",
      "steps": null,
      "img": "https:\/\/cdn.salamatiman.ir\/images\/exercises\/124.jpg",
      "images": "https:\/\/cdn.salamatiman.ir\/images\/exercises\/124.jpg",
      "show_to_user": null,
      "video": null,
      "category": 5,
      "minutes": 30,
      "difficulty": null,
      "uid": null
    }
  ];

  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        surfaceTintColor: Constants.primaryColor,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(10.sp),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        spreadRadius: 0.0,
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                  child: TextFormField(
                    autofocus: true,
                    style: TextStyle(fontSize: 14.sp),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8.sp),
                      isDense: true,
                      border: InputBorder.none,
                      hintText: "جستجوی تمرین...",
                      hintStyle: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 14.sp,
                      ),
                      suffixIconConstraints: BoxConstraints(
                        maxHeight: 50.sp,
                      ),
                      suffixIcon: GestureDetector(
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          padding: EdgeInsets.only(right: 7.sp, left: 5.sp),
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color: Colors.grey.shade300,
                                width: 1,
                              ),
                            ),
                          ),
                          child: Icon(
                            Icons.search,
                            size: 21.sp,
                          ),
                        ),
                        onTap: () {
                          controller.exerciseSearch(
                              search: controller.searchText.value.toString());
                        },
                      ),
                    ),
                    onChanged: (String val) {
                      controller.searchText(val.toString());
                      if (_debounce?.isActive ?? false) _debounce!.cancel();
                      _debounce = Timer(const Duration(seconds: 2), () async {
                        controller.exerciseSearch(search: val.toString());
                      });
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(
                      top: 5, left: 10, right: 10, bottom: 7),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.grey.shade300,
                        width: 1,
                      ),
                    ),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: defaultSports.map<Widget>(
                        (item) {
                          final sport = SportModel.fromJson(item);
                          return Container(
                            margin: EdgeInsets.only(left: 5.sp),
                            child: GestureDetector(
                              onTap: () {
                                AddSportRecord.add(sport);
                              },
                              child: Chip(
                                label: Text(
                                  sport.description.toString(),
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.loadingSport.value) {
                return Center(
                  child: SpinKitThreeBounce(
                    color: Colors.black45,
                    size: 17.sp,
                  ),
                );
              }
              if (controller.loadingSport.value == false &&
                  controller.sportSearch.isEmpty) {
                return Container();
              }
              final sport = controller.sportSearch;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: sport.map<Widget>((item) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.all(2.sp),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7)),
                        child: ListTile(
                          onTap: () {
                            AddSportRecord.add(item);
                          },
                          contentPadding: EdgeInsets.all(0),
                          title: Text(
                            item.description.toString(),
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.w600),
                            maxLines: 1,
                          ),
                          subtitle: Text(
                            item.title.toString(),
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.grey.shade500,
                            ),
                            maxLines: 1,
                          ),
                          leading: CircleAvatar(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50.sp),
                              child: CachedNetworkImage(
                                imageUrl: item.images.toString(),
                                placeholder: (context, url) => Image.asset(
                                    "assets/images/placeholder.png",
                                    fit: BoxFit.cover,
                                    width: double.infinity),
                                errorWidget: (context, url, error) =>
                                    Image.asset("assets/images/placeholder.png",
                                        fit: BoxFit.cover,
                                        width: double.infinity),
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
