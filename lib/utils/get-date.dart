import 'package:persian_number_utility/persian_number_utility.dart';

abstract class GetDate {
  static DateTime _date = new DateTime.now();

  static today() {
    return _date;
  }

  static isToday(myDate) {
    final dateFormat = _date.toString().split(" ")[0];
    return dateFormat.toString() == myDate.toString() ? true : false;
  }

  static todayOnlyDate() {
    return dateTimef(_date)[0];
  }

  static todayOnlyDateFormat() {
    final myDate = dateTimef(_date)[0].toString().split("-");

    return dateTimef(_date)[0];
  }

  static todayOnlyTime() {
    return dateTimef(_date)[1];
  }

  static dateTimef(DateTime myDate) {
    final dateSplit = myDate.toString().split(" ");
    return dateSplit;
  }

  static getYesterday() {
    return _date.subtract(Duration(days: 1));
  }

  static getTomorrow() {
    return _date.subtract(Duration(days: -1));
  }

  static isYesterday(mydata) {
    final yesterday = getYesterday();
    final formatDateYesterday =
        yesterday.toString().split(" ")[0].toString().split("-")[2];

    //my date
    var myDateFormat;
    if (mydata.toString().length > 10) {
      myDateFormat = mydata.toString().split(" ")[0].toString().split("-")[2];
    } else {
      myDateFormat = mydata.toString().split("-")[2];
    }
    return int.parse(myDateFormat) == int.parse(formatDateYesterday)
        ? true
        : false;
  }

  static isTomorrow(mydata) {
    final tomorrow = getTomorrow();
    final formatDateYesterday =
        tomorrow.toString().split(" ")[0].toString().split("-")[2];

    //my date
    var myDateFormat;
    if (mydata.toString().length > 10) {
      myDateFormat = mydata.toString().split(" ")[0].toString().split("-")[2];
    } else {
      myDateFormat = mydata.toString().split("-")[2];
    }
    return int.parse(myDateFormat) == int.parse(formatDateYesterday)
        ? true
        : false;
  }

  static toDate(date) {
    var formatDate, formatTime;
    if (date.length > 10) {
      formatDate = date.toString().split(" ")[0].toString().split("-");
      formatTime = date.toString().split(" ")[1].toString().split(":");
    } else {
      formatDate = date.toString().split(" ")[0].toString().split("-");
    }

    return date.length > 10
        ? DateTime(
            int.parse(formatDate[0]),
            int.parse(formatDate[1]),
            int.parse(formatDate[2]),
            int.parse(formatTime[0]),
            int.parse(formatTime[1]),
            int.parse(formatTime[2].split('.')[0]))
        : DateTime(int.parse(formatDate[0]), int.parse(formatDate[1]),
            int.parse(formatDate[2]));
  }

  static increment(int count) {
    final formatDate = _date
        .subtract(Duration(days: -count))
        .toString()
        .split(" ")[0]
        .toString()
        .split("-");
    final formatTime = _date
        .subtract(Duration(days: -count))
        .toString()
        .split(" ")[1]
        .toString()
        .split(":");
    return DateTime(
        int.parse(formatDate[0]),
        int.parse(formatDate[1]),
        int.parse(formatDate[2]),
        int.parse(formatTime[0]),
        int.parse(formatTime[1]),
        int.parse(formatTime[2].split('.')[0]));
  }

  static decrement(int count) {
    final formatDate = _date
        .subtract(Duration(days: count))
        .toString()
        .split(" ")[0]
        .toString()
        .split("-");
    final formatTime = _date
        .subtract(Duration(days: count))
        .toString()
        .split(" ")[1]
        .toString()
        .split(":");
    return DateTime(
        int.parse(formatDate[0]),
        int.parse(formatDate[1]),
        int.parse(formatDate[2]),
        int.parse(formatTime[0]),
        int.parse(formatTime[1]),
        int.parse(formatTime[2].split('.')[0]));
  }

  static getDateResult(userDate) {
    final result = userDate == ""
        ? "امروز".toString()
        : GetDate.isYesterday(userDate)
            ? "دیروز"
            : GetDate.isTomorrow(userDate)
                ? "فردا"
                : GetDate.isToday(userDate)
                    ? "امروز"
                    : userDate.toString().toPersianDate();
    return result;
  }

  static changeDateOnlyOneDay({required int incOrDec, required String date}) {
    List formatDate = [];
    List formatTime = [];
    var res;
    if (date.length > 10) {
      formatDate = toDate(date)
          .subtract(Duration(days: incOrDec))
          .toString()
          .split(" ")[0]
          .toString()
          .split("-");
      formatTime = toDate(date)
          .subtract(Duration(days: incOrDec))
          .toString()
          .split(" ")[1]
          .toString()
          .split(":");
      res = DateTime(
          int.parse(formatDate[0]),
          int.parse(formatDate[1]),
          int.parse(formatDate[2]),
          int.parse(formatTime[0]),
          int.parse(formatTime[1]),
          int.parse(formatTime[2].split('.')[0]));
    } else {
      formatDate = toDate(date)
          .subtract(Duration(days: incOrDec))
          .toString()
          .split(" ")[0]
          .toString()
          .split("-");
      res = DateTime(
        int.parse(formatDate[0]),
        int.parse(formatDate[1]),
        int.parse(formatDate[2]),
      );
    }
    return res;
  }
}
