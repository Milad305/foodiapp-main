import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:salamatiman/getx/accordion/accordion_getter.dart';
import 'package:salamatiman/getx/auth/auth-getter.dart';
import 'package:salamatiman/getx/food/foods.dart';
import 'package:salamatiman/getx/home/home-getter.dart';
import 'package:salamatiman/getx/nutrient/nutrient.dart';
import 'package:salamatiman/getx/target/target-getter.dart';
import 'package:salamatiman/view/main/app_main.dart';

import '../view/auth/auth-main.dart';

abstract class Constants {
  static final storage = GetStorage();
  static const String BaseUrl = "api.salamatiman.ir";
  static String? userToken = GetStorage().read('UserToken');
  static var userInfo = GetStorage().read('UserInfo');
  static var isPermissionActive = GetStorage().read('isPermissionActive');
  static var smsCode = GetStorage().read('smsCode');
  static var config = "";
  static String token = "";
  static bool forBazzar = false;
  static bool bazzarStatus = false;

  static final smsLoginThemeId = 329134;
  static final smsRegisterThemeId = 876674;
  static final smsToken = "";

  static Color primaryColor = Color.fromARGB(255, 249, 249, 249);
  static Color secondaryColor = Color.fromARGB(255, 45, 211, 194);
  static Color secondaryHeaderColor = Color(0xFFffffff);
  static Color shadowColor = Color(0xffdedede);
  static Color textColor = Colors.grey.shade600;
  static Color textSelected = Color(0xFF4a148c);
  static Color boxColor = Colors.white;

  static Color appleEmptyColor = Colors.grey.shade600;
  static Color appleFullColor = Color(0xFF23ad19);
  static Color appleLowColor = Color(0xFFf99501);
  static Color appleOverFlowColor = Color.fromARGB(255, 238, 15, 79);
  static Color shadeColor = Color.fromARGB(248, 198, 198, 198);

  static Color loginPageColor = Color.fromARGB(255, 255, 255, 255);

  static Color activeColor = Color(0xFF23ad19);
  static Color deActiveColor = Color.fromARGB(255, 217, 217, 217);

  static Color textBtnColor = Color.fromARGB(255, 245, 79, 1);
  static Color radioBtnColor = Color.fromARGB(255, 255, 105, 0);
  static Color waterColor = Color(0xFF09C3DB);

  static Color disabledColor = Color(0xFFBFBFC4);
  static Color secoundaryColor = Color(0xFFF8F8F8);
  static Color warningColor = Color(0xFFFF6F10);
  static Color primaryColor2 = Color(0xFF23ad19);
  static Color dangerColor = Color(0xFFED2F2F);
  static Color successColor = Color(0xFF2DBF64);
  static Color textFieldBg = Color.fromARGB(255, 242, 242, 242);

  static Color antioxidants = Color.fromARGB(255, 151, 71, 255);
  static Color dent = Color.fromARGB(255, 82, 206, 132);
  static Color vitamins = Color.fromARGB(255, 241, 51, 51);
  static Color immuneSystem = Color.fromARGB(255, 39, 172, 242);
  static Color electrolytes = Color.fromARGB(255, 255, 200, 14);
  static Color minerals = Color.fromARGB(255, 85, 72, 26);
  static Color metabolism = Color.fromARGB(255, 38, 0, 255);

  static String primaryFontFamily = "dana";
  static String primaryFontFamilyAdad = "vaziradad";

  static double appleSize = Get.width * 0.45;

  static getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }

  static List<String> planDuration = ["1 ماهه", "3 ماهه", "6 ماهه", "1 ساله"];
  static List<int> planDurationNum = [1, 3, 6, 12];
  static List<String> planPay = ["pay", "zarinpal"];
  static List<String> planFaPay = ["پی", "زرین پال"];

  static String replaceFarsiNumber(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const farsi = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];

    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(english[i], farsi[i]);
    }

    return input;
  }

  static Duration parseDuration(String s) {
    int hours = 0;
    int minutes = 0;
    int micros;
    List<String> parts = s.split(':');
    if (parts.length > 2) {
      hours = int.parse(parts[parts.length - 3]);
    }
    if (parts.length > 1) {
      minutes = int.parse(parts[parts.length - 2]);
    }
    micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
    return Duration(hours: hours, minutes: minutes, microseconds: micros);
  }

  static Map<String, String> nutrientsTranslate = {
    'protein': 'پروتئین',
    'fat': 'چربی',
    'carbohydrate': 'کربوهیدرات',
    'energy': 'انرژی',
    'exercise': 'ورزش',
    'activity': 'فعالیت',
    'bmr': 'bmr',
    'burned': 'سوخته'
  };

  static Map<String, String> biometricAllUnits = {
    "kg": "کیلو گرم",
    "cm": "سانتی متر",
    "bpm": "ضربان بر دقیقه",
    "mmol\/L": "میلی مول بر لیتر",
    "mg\/dL": "میلی گرم بر دسی لیتر",
    "°C": "سانتی گراد",
    "°F": "فارنهایت",
    "Kelvin": "کلوین",
    "%": "درصد",
    "minutes": "دقیقه"
  };

  static List ListWeeks = [
    {
      "id": 1,
      "title": "هفت روز اخیر",
    },
    {
      "id": 2,
      "title": "دو هفته اخیر",
    },
    {
      "id": 3,
      "title": "سه هفته اخیر",
    },
    {
      "id": 4,
      "title": "چهار هفته اخیر",
    },
    {
      "id": 8,
      "title": "هشت هفته اخیر",
    },
    {
      "id": 13,
      "title": "سه ماه اخیر",
    },
    {
      "id": 26,
      "title": "شش ماه اخیر",
    },
    {
      "id": 52,
      "title": "یک سال گذشته",
    },
    {
      "id": 520,
      "title": "از ابتدا",
    }
  ];

  static generateGender(int val) {
    switch (val) {
      case 0:
        return "male";
      case 1:
        return "female";
      case 2:
        return "pregnant";
      default:
        return "lactating";
    }
  }

  static genderFa(val) {
    switch (val) {
      case "male":
        return "مرد";
      case "female":
        return "زن";
      case "pregnant":
        return "حامله";
      default:
        return "شیرده";
    }
  }

  static List targetTypeName = [
    "",
    "افزایش وزن",
    "کاهش وزن",
    "وزن",
    "قدم زدن",
  ];

  static List obesitySlimming = ["0.2", "0.5", "0.7", "0.9"];

  static getBMI(bmi) {
    if (bmi < 16.5) {
      return "دچار کمبود وزن شدید";
    } else if (bmi >= 16.5 && bmi <= 18.5) {
      return "کمبود وزن";
    } else if (bmi >= 18.5 && bmi <= 25) {
      return "عادی";
    } else if (bmi >= 25 && bmi <= 30) {
      return "اضافه وزن";
    } else if (bmi >= 30 && bmi <= 35) {
      return "چاقی درجه یک";
    } else if (bmi >= 35 && bmi <= 40) {
      return "چاقی درجه دو";
    } else if (bmi >= 40) {
      return "چاقی درجه سه";
    }
  }

  static exitInProfile() {
    Constants.token = "";
    Constants.userInfo = "";
    Constants.userToken = "";
    Constants.storage.write('UserToken', "");
    Constants.storage.write('UserInfo', "");
    Constants.storage.write('smsCode', "");
    return Get.to(() => AuthMain());
  }

  static logout() {
    Constants.token = "";
    Constants.userInfo = "";
    Constants.userToken = "";
    Constants.storage.write('UserToken', "");
    Constants.storage.write('UserInfo', "");
    Constants.storage.write('smsCode', "");
    Get.delete<AccordionGetter>(force: true);
    Get.delete<AuthGetter>(force: true);
    Get.delete<FoodGetter>(force: true);
    Get.delete<HomeGetter>(force: true);
    Get.delete<NutrientGetter>(force: true);
    Get.delete<PersonTargetGeter>(force: true);
    Get.offAll(() => AppMain());
    Get.to(() => AuthMain());
  }

  static const List<Color> primarygradiant = [
    Color(0xFF5ae291),
    Color(0xFF2dd3c2)
  ];
  static const List<Color> disablegradiant = [
    Color(0xFFBFBFC4),
    Color(0xFFBFBFC4)
  ];

  static const List<Color> profiileBg = [
    Color.fromARGB(255, 0, 0, 0),
    Color.fromARGB(0, 0, 0, 0)
  ];
  static const List<Color> chartGradiant = [
    Color.fromARGB(255, 255, 105, 0),
    Color.fromARGB(255, 255, 200, 14)
  ];
  static const List<Color> chartGradiant2 = [
    Color(0xFFf99501),
    Color.fromARGB(255, 238, 15, 79)
  ];
}
