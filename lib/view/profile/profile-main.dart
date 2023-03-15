import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:salamatiman/getx/auth/auth-getter.dart';
import 'package:salamatiman/utils/constants.dart';
import 'package:salamatiman/utils/get-date.dart';
import 'package:salamatiman/widgets/datepicker/flutter_datepicker.dart';

import 'background_rounded_pic.dart';
import 'change_profile_data/change_profile_data_main.dart';
import 'gender.dart';
import 'profile_title_edit.dart';
import 'profile_user_activity.dart';
import 'user_tile.dart';

class ProfileMain extends GetView<AuthGetter> {
  var user;

  ProfileMain({Key? key}) : super(key: key) {
    Get.lazyPut(() => AuthGetter());
    user = GetStorage().read('UserInfo');
  }

  @override
  Widget build(BuildContext context) {
    Color headerColor = Constants.secondaryColor;
    Color headerTxtColor = Colors.white;

    final List lactationPeriod = [
      {"id": 1, "title": "شش ماه اول"},
      {"id": 2, "title": "شش ماه دوم"}
    ];
    final List pregnantPeriod = [
      {"id": 1, "title": "سه ماه اول"},
      {"id": 2, "title": "سه ماه دوم"},
      {"id": 3, "title": "سه ماه سوم"}
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(() {
          if (controller.userInfo.isNotEmpty) {
            user = controller.userInfo[0];
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: Get.height / 3,
                  width: double.maxFinite,
                  child: Stack(children: [
                    const BackgroundRoundedPic(
                        imageAsset: "assets/images/profbg.png"),
                    Positioned(
                        right: 10,
                        top: 10,
                        child: InkWell(
                            onTap: () => Get.back(),
                            child: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ))),
                    Positioned(
                      left: Get.width / 3.2,
                      top: Get.height / 6,
                      right: Get.width / 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 90,
                                height: 90,
                                decoration: BoxDecoration(
                                    // ignore: prefer_const_literals_to_create_immutables
                                    boxShadow: <BoxShadow>[
                                      const BoxShadow(
                                          color: Colors.black, blurRadius: 10)
                                    ],
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                        color: Colors.white, width: 2.5)),
                                alignment: Alignment.center,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.network(
                                    controller.avatar.isEmpty
                                        ? "https://${Constants.BaseUrl}${user["avatar"]}"
                                        : "https://${Constants.BaseUrl}/${controller.avatar.value}",
                                    fit: BoxFit.fill,
                                    alignment: Alignment.center,
                                    width: 90,
                                    height: 90,
                                    semanticLabel: "${user["name"]}",
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: Get.height / 200,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
                SizedBox(
                    width: Get.width,
                    child: GestureDetector(
                      onTap: () => controller.changeAvatar(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "ویرایش عکس پروفایل",
                            style: TextStyle(color: Constants.secondaryColor),
                          ),
                          ImageIcon(
                            const AssetImage("assets/images/edit.png"),
                            color: Constants.secondaryColor,
                          )
                        ],
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      Get.width / 17, 15, Get.width / 17, 15),
                  child: Container(
                      width: Get.width,
                      height: Get.height / 17,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Constants.shadeColor, blurRadius: 10)
                          ],
                          color: Colors.white),
                      child: Row(
                        children: [
                          const Text("      نام و نام خانوادگی  "),
                          VerticalDivider(
                            color: Constants.shadeColor,
                            indent: Get.height / 90,
                            endIndent: Get.height / 90,
                            thickness: 1,
                          ),
                          GestureDetector(
                            onTap: () {
                              print(GetStorage().read('UserInfo'));
                              ChangeProfileData.show(
                                  title: "ویرایش نام",
                                  name: "name",
                                  value: "${user['name']}",
                                  type: TextInputType.text,
                                  align: TextDirection.rtl,
                                  isBack: true);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "${user['name']}",
                                  style: TextStyle(fontSize: 15.sp),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      Get.width / 17, 0, Get.width / 17, 15),
                  child: Container(
                    height: Get.height / 10,
                    width: Get.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: <BoxShadow>[
                          BoxShadow(color: Constants.shadeColor, blurRadius: 10)
                        ],
                        color: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: Get.height / 60, right: Get.width / 12),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  print(Constants.userInfo);
                                  ChangeProfileData.show(
                                      title: "ویرایش وزن",
                                      name: "weight",
                                      value: "${user['weight']}",
                                      type: TextInputType.number,
                                      align: TextDirection.ltr,
                                      isBack: true);
                                },
                                child: Text(
                                  "وزن",
                                  style: TextStyle(fontSize: 17.sp),
                                ),
                              ),
                              Text(
                                "${user['weight']}".toPersianDigit(),
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        VerticalDivider(
                          color: Constants.shadeColor,
                          indent: Get.height / 90,
                          endIndent: Get.height / 90,
                          thickness: 1,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: Get.height / 60),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  ChangeProfileData.show(
                                      title: "ویرایش قد",
                                      name: "height",
                                      value: "${user['height']}",
                                      type: TextInputType.number,
                                      align: TextDirection.ltr,
                                      isBack: true);
                                },
                                child: Text(
                                  "قد",
                                  style: TextStyle(fontSize: 17.sp),
                                ),
                              ),
                              Text(
                                "${user['height']}".toPersianDigit(),
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        VerticalDivider(
                          color: Constants.shadeColor,
                          indent: Get.height / 90,
                          endIndent: Get.height / 90,
                          thickness: 1,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: Get.height / 60, left: Get.width / 12),
                          child: GestureDetector(
                            onTap: () {
                              showMaterialModalBottomSheet(
                                bounce: true,
                                context: context,
                                builder: (context) {
                                  return Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.only(
                                        top: 20,
                                        bottom: 50,
                                        right: 10,
                                        left: 10),
                                    child: Wrap(
                                      children: [
                                        SizedBox(
                                          width: double.infinity,
                                          child: Text(
                                            "جنسیت:",
                                            style: TextStyle(fontSize: 24.sp),
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          margin:
                                              const EdgeInsets.only(top: 40),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              ProfileGenderSelect(
                                                title: "مرد",
                                                icon: Icons.man,
                                                primaryColor:
                                                    Constants.secondaryColor,
                                                gender: "male",
                                              ),
                                              ProfileGenderSelect(
                                                title: "زن",
                                                icon: Icons.woman,
                                                primaryColor:
                                                    Constants.secondaryColor,
                                                gender: "female",
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: Column(
                              children: [
                                Text(
                                  "جنسیت",
                                  style: TextStyle(fontSize: 17.sp),
                                ),
                                Text(
                                  "${Constants.genderFa(user['gender'])}"
                                      .toPersianDigit(),
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: Get.height / 130,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: Get.width / 17),
                      child: UserTile(
                        icon: const ImageIcon(
                          AssetImage("assets/images/metabolism 1.png"),
                          size: 30,
                        ),
                        title: "متابولیسم",
                        keyTitle: "",
                        value: '${user['bmr_computed']}',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: Get.width / 17),
                      child: UserTile(
                        icon: const ImageIcon(
                          AssetImage("assets/images/bmi1.png"),
                          size: 30,
                        ),
                        title: "BMI",
                        keyTitle: "",
                        value: "${user['bmi']}",
                      ),
                    ),
                  ],
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     GetBuilder<PlansGetx>(builder: (logic) {
                //       return Obx(() {
                //         return
                //          Padding(
                //            padding: const EdgeInsets.all(8.0),
                //            child: UserTile(
                //             primaryColor: headerColor,
                //             icon: Icon(
                //               Icons.payment_outlined,
                //               color: headerColor,
                //             ),
                //             title: "پرداخت‌ها",
                //             keyTitle: logic.plansLoding.value
                //                 ? "درحال دریافت داده‌ها"
                //                 : "مورد",
                //             value: logic.plansLoding.value
                //                 ? ""
                //                 : '${logic.transactions.length}',
                //         ),
                //          );
                //       });
                //     }),
                //     GetBuilder<PlansGetx>(builder: (logic) {
                //       if (logic.subscriptions.isEmpty) {
                //         logic.getUserSubscriptions();
                //       }
                //       List<SubscriptionsModel> subscriptions = [];
                //       for (int i = 0; i < logic.subscriptions.length; i++) {
                //         if (logic.subscriptions[i].status == "active") {
                //           subscriptions.add(logic.subscriptions[i]);
                //         }
                //       }
                //       return Obx(() {
                //         return Padding(
                //           padding: const EdgeInsets.all(8.0),
                //           child: UserTile(
                //             primaryColor: headerColor,
                //             icon: Icon(
                //               Icons.add_box_outlined,
                //               color: headerColor,
                //             ),
                //             title: "پلن",
                //             keyTitle: logic.plansLoding.value
                //                 ? "درحال دریافت داده‌ها"
                //                 : "فعال",
                //             value: logic.plansLoding.value
                //                 ? ""
                //                 : '${subscriptions.length}',
                //           ),
                //         );
                //       });
                //     }),
                //   ],
                // ),
                SizedBox(height: Get.height / 70),
                // ProfileTitleEdit(
                //   title:
                //       " تاریخ ثبت‌ نام: ${user["created_at"].toString().split(" ")[0].toString().toPersianDate()} ",
                //   onTap: null,
                //   edit: false,
                // ),
                // SizedBox(height: 20,),
                /*ProfileTitleEdit(
                title:
                    " آخرین بروزرسانی: ${user["updated_at"].toString().split(" ")[0].toString().toPersianDate()} ",
                onTap: null,
                edit: false,
              ),*/

                Padding(
                  padding: EdgeInsets.only(
                      left: Get.width / 17, right: Get.width / 17),
                  child: ProfileTitleEdit(
                    title: "تاریخ تولد      :",
                    onTap: () {
                      Get.defaultDialog(
                        title: "ویرایش تاریخ تولد",
                        titleStyle: TextStyle(fontSize: 16.sp),
                        contentPadding: EdgeInsets.all(3.sp),
                        content: Directionality(
                          textDirection: TextDirection.ltr,
                          child: Column(
                            children: [
                              LinearDatePicker(
                                isJalaali: true,
                                showDay: true,
                                showMonthName: true,
                                columnWidth: Get.width * 0.21,
                                selectedRowStyle: TextStyle(
                                  fontSize: 18.sp,
                                  color: Constants.activeColor,
                                  fontFamily: Constants.primaryFontFamilyAdad,
                                ),
                                unselectedRowStyle: TextStyle(
                                  fontSize: 16.sp,
                                  fontFamily: Constants.primaryFontFamilyAdad,
                                ),
                                labelStyle: TextStyle(
                                  color: Constants.textBtnColor,
                                  fontSize: 17.sp,
                                  fontFamily: Constants.primaryFontFamilyAdad,
                                ),
                                dateChangeListener: (String selectedDate) {
                                  controller.ageDate(selectedDate);
                                },
                              ),
                              SizedBox(height: 15.sp),
                              GestureDetector(
                                onTap: () async {
                                  Get.find<AuthGetter>().changeProfileField(
                                      name: "birth_date",
                                      val: controller.ageDate.value == ""
                                          ? GetDate.todayOnlyDate()
                                              .toString()
                                              .toPersianDate(
                                                  digitType:
                                                      NumStrLanguage.English)
                                          : controller.ageDate.value,
                                      isBack: true);
                                },
                                child: Container(
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(7.sp),
                                  decoration: BoxDecoration(
                                    color: Constants.secondaryColor,
                                    borderRadius: BorderRadius.circular(7.sp),
                                  ),
                                  child: Text(
                                    "ذخیره",
                                    style: TextStyle(
                                      fontSize: 17.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    edit: true,
                  ),
                ),
                SizedBox(height: Get.height / 70),
                Padding(
                  padding: EdgeInsets.only(
                      left: Get.width / 17, right: Get.width / 17),
                  child: Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Constants.shadeColor, blurRadius: 10)
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                right: Get.width / 19, top: Get.height / 100),
                            child: Text(
                              "میزان فعالیت",
                              style: TextStyle(
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                          Divider(
                            color: Constants.shadeColor,
                            indent: 10,
                            endIndent: 20,
                          ),
                          ProfileUserAvtivity(
                              user: user, primaryColor: headerColor),
                        ],
                      )),
                ),

                SizedBox(
                  height: Get.height / 70,
                ),

                Padding(
                  padding: EdgeInsets.only(
                      left: Get.width / 17, right: Get.width / 17),
                  child: Container(
                    height: Get.height / 15,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: <BoxShadow>[
                          BoxShadow(color: Constants.shadeColor, blurRadius: 10)
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: Get.width / 18),
                          child: Text(
                            "شماره موبایل     :",
                            style: TextStyle(
                                fontSize: 15.sp, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text(
                            user["mobile"].toString().toPersianDigit(),
                            style: TextStyle(color: Colors.grey.shade500),
                          ),
                        ),
                      ],
                    ),
                  ),
                )

                // ProfileTitleEdit(
                //   title: " شماره همراه: ${user["mobile"]} ",
                //   onTap: () {
                //     ChangeProfileData.show(
                //         title: "ویرایش شماره همراه",
                //         name: "mobile",
                //         value: "${user['mobile']}",
                //         type: TextInputType.number,
                //         align: TextDirection.ltr,
                //         isBack: true);
                //   },
                //   edit: true,
                // ),

                // Padding(
                //   padding: const EdgeInsets.only(right: 10, bottom: 0, top: 0),
                //   child: Column(
                //     children: [
                //       ProfileSwitch(
                //           primaryColor: headerColor,
                //           value: user['pregnant_period'] < 1 ? false : true,
                //           title: "من باردارم",
                //           onChanged: (val) {
                //             Get.find<AuthGetter>().changeProfileField(
                //                 name: "pregnant_period",
                //                 val: user["pregnant_period"] == 0 ? 1 : 0,
                //                 isBack: false);
                //           }),
                //       if (user['pregnant_period'] > 0) ...[
                //         Container(
                //           width: double.infinity,
                //           alignment: Alignment.centerRight,
                //           child: Wrap(
                //             crossAxisAlignment: WrapCrossAlignment.center,
                //             alignment: WrapAlignment.start,
                //             children: [
                //               const Text("دوره بارداری"),
                //               const SizedBox(width: 20),
                //               SizedBox(
                //                 width: Get.width * 0.5,
                //                 child: DropdownButton2(
                //                   isDense: true,
                //                   buttonHeight: 35,
                //                   alignment: Alignment.centerRight,
                //                   buttonPadding:
                //                       const EdgeInsets.symmetric(horizontal: 7),
                //                   buttonDecoration: BoxDecoration(
                //                     border: Border.all(
                //                         width: 1, color: Colors.grey.shade300),
                //                     borderRadius: BorderRadius.circular(7),
                //                   ),
                //                   isExpanded: true,
                //                   underline: const SizedBox(height: 0),
                //                   value: pregnantPeriod[
                //                       user["pregnant_period"] - 1]["id"],
                //                   items: pregnantPeriod
                //                       .map((item) => DropdownMenuItem(
                //                             value: item["id"],
                //                             child: Text("${item["title"]}"),
                //                           ))
                //                       .toList(),
                //                   onChanged: (val) {
                //                     Get.find<AuthGetter>().changeProfileField(
                //                         name: "pregnant_period",
                //                         val: int.parse(val.toString()),
                //                         isBack: false);
                //                   },
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //         const SizedBox(height: 10),
                //       ],
                //       SizedBox(
                //         height: 4,
                //         child: Divider(color: Colors.grey.shade200),
                //       ),
                //     ],
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(right: 10, bottom: 0, top: 0),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       ProfileSwitch(
                //           primaryColor: headerColor,
                //           value: user['lactation_period'] < 1 ? false : true,
                //           title: "در دوران شیردهی هستم",
                //           onChanged: (val) {
                //             Get.find<AuthGetter>().changeProfileField(
                //                 name: "lactation_period",
                //                 val: user["lactation_period"] == 0 ? 1 : 0,
                //                 isBack: false);
                //           }),
                //       if (user['lactation_period'] > 0) ...[
                //         Wrap(
                //           crossAxisAlignment: WrapCrossAlignment.center,
                //           children: [
                //             Text("دوره شیردهی"),
                //             SizedBox(width: 20),
                //             SizedBox(
                //               width: Get.width * 0.5,
                //               child: DropdownButton2(
                //                 isDense: true,
                //                 buttonHeight: 35,
                //                 alignment: Alignment.centerRight,
                //                 buttonPadding:
                //                     const EdgeInsets.symmetric(horizontal: 7),
                //                 buttonDecoration: BoxDecoration(
                //                   border: Border.all(
                //                       width: 1, color: Colors.grey.shade300),
                //                   borderRadius: BorderRadius.circular(7),
                //                 ),
                //                 isExpanded: true,
                //                 underline: const SizedBox(height: 0),
                //                 value: lactationPeriod[
                //                     user["lactation_period"] - 1]["id"],
                //                 items: lactationPeriod
                //                     .map((item) => DropdownMenuItem(
                //                           value: item["id"],
                //                           child: Text("${item["title"]}"),
                //                         ))
                //                     .toList(),
                //                 onChanged: (val) {
                //                   Get.find<AuthGetter>().changeProfileField(
                //                       name: "lactation_period",
                //                       val: int.parse(val.toString()),
                //                       isBack: false);
                //                 },
                //               ),
                //             ),
                //           ],
                //         )
                //       ],
                //     ],
                //   ),
                // ),
                ,
                SizedBox(height: 15),
                Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: Get.width / 17),
                      child: Text(
                          "تاریخ ثبت نام   : ${user["created_at"].toString().split(" ")[0].toString().toPersianDate()}"),
                    )),
                // Container(
                //   width: double.infinity,
                //   child: Text("دور مچ"),
                //   alignment: Alignment.centerRight,
                //   margin: EdgeInsets.only(bottom: 10, right: 10),
                // ),
                // Container(
                //   width: double.infinity,
                //   padding: EdgeInsets.symmetric(horizontal: 10),
                //   child: ProfileWrist(defaultWrist: user["wrist"]),
                // ),
                SizedBox(height: Get.height / 70),
                //  GetBuilder<PlansGetx>(builder: (logic) {
                //       if (logic.subscriptions.isEmpty) {
                //         logic.getUserSubscriptions();
                //       }
                //       List<SubscriptionsModel> subscriptions = [];
                //       for (int i = 0; i < logic.subscriptions.length; i++) {
                //         if (logic.subscriptions[i].status == "active") {
                //           subscriptions.add(logic.subscriptions[i]);
                //         }
                //       }
                //       return Obx(() {
                //         return

                //   Padding(
                //   padding:  EdgeInsets.only(left: Get.width/17,right: Get.width/17),
                //   child: Container(
                //     height: Get.height/17,
                //     width: Get.width,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(16),
                //       gradient: const LinearGradient(
                //         colors: Constants.primarygradiant,
                //         begin: Alignment.topCenter,
                //         end: Alignment.bottomCenter

                //         )
                //     ),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //       Text( "پلن ",style: TextStyle(color: Colors.white),),
                //       Text( logic.plansLoding.value
                //               ? "درحال دریافت داده‌ها"
                //               : "فعال",style: TextStyle(color: Colors.white),),
                //       Text( logic.plansLoding.value
                //               ? ""
                //               : '${subscriptions.length}',style: TextStyle(color: Colors.white),),
                //     ],),
                //   ),
                // );
                //       });
                //     }),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: () {
                      Constants.logout();
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.logout,
                          color: headerColor,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "خروج ار حساب کاربری",
                          style: TextStyle(color: headerColor),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                //Text("${user.toString()}"),
              ],
            ),
          );
        }),
      ),
    );
  }
}
