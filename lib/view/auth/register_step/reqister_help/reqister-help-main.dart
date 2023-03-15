import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ReqisterHelpMain extends StatelessWidget {
  final Widget child;
  final title;
  const ReqisterHelpMain({Key? key, required this.child, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Text(
          "$title",
          style: TextStyle(fontSize: 20.sp, color: Colors.black54),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        foregroundColor: Colors.black54,
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Get.back(),
          tooltip: "بستن راهنما",
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Align(
              alignment: Alignment.topRight,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
