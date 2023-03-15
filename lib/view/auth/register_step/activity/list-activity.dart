import 'package:flutter/material.dart';
abstract class Avtivity{
  static List listActivity = [
    {
      "title": "خیلی سبک",
      "content": "خانوم‌ها یا آقایان مسن و افراد دارای محدودیت حرکتی",
      "icon": Icon(Icons.accessible_forward),
    },
    {
      "title": "سبک",
      "content": "کارمندان،مغازه دارن و خانوم‌های خانه داری که ورزش نمی‌کنند",
      "icon": Icon(Icons.star),
    },
    {
      "title": "متوسط",
      "content": "افزادی کع سه روز در هفته ورزش می‌کنند\r(زمان ورزش 45 دقیقه الی 1 ساعت)",
      "icon": Icon(Icons.help_outline_outlined),
    },
    {
      "title": "سنگین",
      "content": "ورزشکاران نیمه حرفه ای که هر روز به مدت 1 ساعت ورزش می کنند یا کارگران ساختمان",
      "icon": Icon(Icons.accessibility),
    },
    {
      "title": "خیلی سنگین",
      "content": "ورزشکاران حرفه ای با روزی 2 نوبت تمرین و یا کارگران کشاورزی",
      "icon": Icon(Icons.accessibility_sharp),
    }

  ];
}