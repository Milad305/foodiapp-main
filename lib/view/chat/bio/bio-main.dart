import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salamatiman/utils/constants.dart';

class BioMain extends StatelessWidget {
  final user;
  const BioMain({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Constants.secondaryColor,
        backgroundColor: Constants.secondaryColor,
        foregroundColor: Colors.white,
        toolbarHeight: 60,
        centerTitle: true,
        title: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                ("https://${Constants.BaseUrl}${user.img}").toString(),
                width: 50,
                height: 50,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              "${user.name}",
              style: TextStyle(fontSize: 16.sp),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "درباره من",
                    style: TextStyle(
                      color: Constants.secondaryColor,
                      fontSize: 17.sp,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "${user.biography == null || user.biography == "" ? "چیزی وارد نشده" : user.biography}",
                  style: TextStyle(
                    fontSize: 17.sp,
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "مدارک",
                    style: TextStyle(
                      color: Constants.secondaryColor,
                      fontSize: 17.sp,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "${user.credentials == null || user.credentials == "" ? "چیزی وارد نشده" : user.credentials}",
                  style: TextStyle(
                    fontSize: 17.sp,
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
