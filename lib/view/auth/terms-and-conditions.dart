import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salamatiman/utils/constants.dart';

import '../../repo/url_launcher.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myText = "این سیاستنامه  و قوانین برای اپلیکیشن و وب سایت سلامتی من می باشد." +
        "سلامتی من تنها اپلیکیشن تغذیه و رژیم درمانی ایران است که به شما این امکان را می دهد که بتوانید متخصص تغذیه خود را به صورت حضوری یا آنلاین انتخاب و همراه کنید. با این امکان شما در مسیر رسیدن به هدف تنها نخواهید بود و همواره یک متخصص در طول دوره رژیم همراه شما خواهد بود این امکان باعث می شود مسیر رسیدن به هدف راحتتر و قابل دستیابی باشد." +
        "شما با استفاده از اپلیکیشن سلامتی من می توانید اطلاعات غذایی، بیومتریک (قد، وزن، خواب، فشار خون، قند خون و ...)، یادداشت روزانه و ... خود را اضافه کنید و در بخش  کارنامه من  گزارشات روزانه، هفتگی و ماهانه دریافت کنید." +
        "  استفاده و نصب اپلیکیشن تنها با ثبت نام و شماره همراه شخصی میسر است. ثبت نام در اپلیکیشن سلامتی من رایگان است. شما در مراحل ثبت نام اطلاعات کاربری و شخصی خود مانند نام و نام خانوادگی، سن، قد و جنسیت خود را وارد می کنید. اطلاعات وارد شده برای تعامل اپلیکیشن و کاربر مورد نیاز است." +
        "  سلامتی من بدون اجازه کاربر اطلاعات را دراختیار هیچ شخص ثالثی قرار نخواهد داد." +
        "  سلامتی من اقدامات فنی و امنیتی مناسب را جهت جلوگیری از افشا و دسترسی غیرمجاز به اطلاعات کاربران را انجام می دهد." +
        "  ما در مطالعات آماری داده ی کاربران ، به صورت ناشناس و بدون در نظر گرفتن اطلاعات هویتی کاربران این اطلاعات را بررسی می کنیم." +
        "   وظیفه حفظ و نگهداری از اطلاعات شخصی و هزینه ها و ابزارها و تجهیزات مورد استفاده برای دسترسی به وب سایت و اپلیکیشن سلامتی من بر عهده کاربر استفاده کننده می باشد." +
        "   کاربران در هربار استفاده از اپلیکیشن می توانند اطلاعات شخصی خود را تغییر دهند. بیشتر امکانات موجود در اپلیکیشن سلامتی من رایگان است تنها بخش اهداف غذایی در قسمت کارنامه نیاز به خریداری پلن و فعال سازی دارد که تنها کاربران بالای 18 سال حق خرید از این سرویس را دارند." +
        "   تیم سلامتی من همواره پذیرای انتقادات و پیشنهادات شما کاربران گرامی است می توانید با مسیرهای ارتباطی زیر با ما در ارتباط باشید." +
        "  Info@salamatiman.ir" +
        "<br><br>" +
        "  <a href='www.salamatiman.ir' >www.salamatiman.ir</a>";
    return Scaffold(
      appBar: AppBar(
        title: Text("قوانین"),
        backgroundColor: Constants.primaryColor,
        surfaceTintColor: Constants.primaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(10.sp),
        child: SingleChildScrollView(
          child: Html(
              data: myText,
              style: {
                "body": Style(
                  fontSize: FontSize.xLarge,
                  textAlign: TextAlign.justify,
                )
              },
              onLinkTap: (String? url, RenderContext context,
                  Map<String, String> attributes, element) {
                LaunchUrlExternal(url);
              }),
        ),
      ),
    );
  }
}
