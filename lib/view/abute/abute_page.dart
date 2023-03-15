import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:salamatiman/repo/url_launcher.dart';
import 'package:salamatiman/utils/constants.dart';
import 'package:salamatiman/view/profile/background_rounded_pic.dart';

class AbutePage extends StatelessWidget {
  const AbutePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(children: [
                const BackgroundRoundedPic(
                    imageAsset: "assets/images/sports-tools 3.png"),
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                      onTap: () => Get.back(),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      )),
                ),
                Positioned(
                    top: Get.height / 7,
                    left: Get.width / 2.4, 
                    child:  Text(
                      "درباره  ما",
                      style: TextStyle(fontSize: 20.sp, color: Colors.white),
                    ))
              ]),
              Padding(
                padding: EdgeInsets.fromLTRB(Get.width / 17, Get.height / 50,
                    Get.width / 17, Get.height / 50),
                child: const Text("""

سلامتی من، هوشمندانه بخورید سالم بمانید

"سلامتی من" تنها اپلیکیشن تغذیه و رژیم درمانی ایران است که به شما این امکان را می دهد که بتوانید متخصص تغذیه خود را به صورت حضوری یا آنلاین انتخاب و همراه کنید. با این امکان شما در مسیر رسیدن به هدف تنها نخواهید بود و همواره یک متخصص در طول دوره رژیم همراه شما خواهد بود این امکان باعث می شود مسیر رسیدن به هدف راحتتر و قابل دستیابی باشد.

شما با استفاده از اپلیکیشن سلامتی من می توانید اطلاعات غذایی، بیومتریک (قد، وزن، خواب، فشار خون، قند خون و ...)، یادداشت روزانه و ... خود را اضافه کنید و در بخش "کارنامه من" گزارشات روزانه، هفتگی و ماهانه دریافت کنید.

همچنین متخصصان تغذیه با استفاده از وب سایت "سلامتی من"، میتوانند رژیم تغذیه ای مراجعه کنندگان خود را به صورت علمی تنظیم و سوابق آنها را برای مراجعات بعدی و همچنین رصد آنلاین مراجعان خود استفاده کنند.

ما از داده های خود را از منابع دقیق و تایید شده انتخاب می کنیم و همواره آخرین تغییرات را بروز رسانی ها می کنیم.

تیم "سلامتی من" همواره پذیرای انتقادات و پیشنهادات شما کاربران گرامی است می توانید با مسیرهای ارتباطی زیر با ما در ارتباط باشید.


                               
"""),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("info@salamatiman.ir"),
                    SizedBox(width: Get.width/70,),
                    Image.asset("assets/images/globe2.png",width: 25,),
                    
                    ],),
              SizedBox(height: Get.height/100),
              GestureDetector(  
                onTap:  () {
                  LaunchUrlExternal(
                      "https://www.salamatiman.ir/");
                },
                child: Container(
                  
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("www.salamatiman.ir"),
                        SizedBox(width: Get.width/70,),
                        Image.asset("assets/images/globe1.png",width: 25,),
                        
                        ],),
                ),
              ),
          
              SizedBox(height: 20.sp),
            ],
          ),
        ),
      ),
    );
  }
}
