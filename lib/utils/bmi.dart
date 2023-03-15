import 'package:get_storage/get_storage.dart';

class UserBMI {
  final userInfo = GetStorage().read('UserInfo');
  static getBMI({weight}) {
    final userInfo = GetStorage().read('UserInfo');
    print(userInfo["height"]);
    var gender = "male";
    var height = userInfo["height"];
    var wrist = userInfo["wrist"] == null ? 20 : userInfo["wrist"];
    var age = userInfo["age"];
    var weight = userInfo["weight"];

    var height_m = height / 100;
    var skl = height / wrist;
    var sklR;
    double normal_weight = 0.0;
    var bmi = (weight / ((height / 100) * (height / 100))).round();

    if (skl > 10.5) {
      sklR = 'slim';
    } else if (skl < 9.5) {
      sklR = 'fat';
    } else {
      sklR = 'normal';
    }

    if (gender == 'male') {
      if (age >= 16 && age < 31) {
        normal_weight = height_m * height_m * 23.3;
      } else if (age >= 31 && age < 45) {
        normal_weight = height_m * height_m * 24.8;
      } else if (age >= 45) {
        normal_weight = height_m * height_m * 25.4;
      }
    } else {
      if (age >= 16 && age < 31) {
        normal_weight = height_m * height_m * 20.8;
      } else if (age >= 31 && age < 40) {
        normal_weight = height_m * height_m * 22.5;
      } else if (age >= 40 && age < 45) {
        normal_weight = height_m * height_m * 24.1;
      } else if (age >= 45) {
        normal_weight = height_m * height_m * 25;
      }
    }

    if ((10 <= age) && (age <= 11) && (height_m < 1.65)) {
      normal_weight = (height_m * height_m) * (age + 8);
    } else if ((12 <= age) && (age <= 15) && (height_m <= 1.65)) {
      normal_weight = (height_m * height_m) * (age + 5);
    } else if ((10 <= age) && (age <= 15) && (height_m >= 1.65)) {
      if (gender == 'male') {
        normal_weight = (height_m * height_m) * 23.3;
      } else {
        normal_weight = (height_m * height_m) * 20.8;
      }
    }
    if (sklR == 'slim') {
      normal_weight *= 0.94;
    } else if (sklR == 'fat') {
      normal_weight *= 1.06;
    }

    return {
      "bmi": bmi,
      "normal_weight": normal_weight.round(),
    };
  }
}
