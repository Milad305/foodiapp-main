import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class ImageTile extends StatelessWidget {
  final image, disc;
  final bool forMe;
  const ImageTile(
      {Key? key, required this.image, required this.disc, required this.forMe})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: forMe ? Alignment.centerRight : Alignment.centerLeft,
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.only(left: forMe ? 20 : 0, right: forMe ? 0 : 20),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(forMe ? 13 : 0),
              topLeft: Radius.circular(13),
              bottomRight: Radius.circular(forMe ? 0 : 13),
              topRight: Radius.circular(13),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: forMe ? Color(0xFFE6E6E9) : Color(0xFFD8D8D9),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(forMe ? 13 : 0),
                  topLeft: Radius.circular(13),
                  bottomRight: Radius.circular(forMe ? 0 : 13),
                  topRight: Radius.circular(13),
                ),
              ),
              child: Column(
                mainAxisAlignment:
                    forMe ? MainAxisAlignment.start : MainAxisAlignment.end,
                crossAxisAlignment:
                    forMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                children: [
                  FadeInImage.assetNetwork(
                    placeholder: "assets/images/placeholder.png",
                    image: "${image["content"]}",
                  ),
                ],
              ),
            ),
          ),
          if (image["createdAt"] != null) ...[
            SizedBox(height: 2),
          ],
          if (image["createdAt"] != null) ...[
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: LayoutBuilder(builder: (context, constraints) {
                final time = image["createdAt"]
                    .toString()
                    .split("T")[1]
                    .toString()
                    .split(".")[0]
                    .toString()
                    .split(":");
                return SizedBox(
                  width: double.infinity,
                  child: Text(
                    time[1].toString().toPersianDigit() +
                        ":" +
                        time[2].toString().toPersianDigit(),
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 15.sp,
                    ),
                    textAlign: forMe ? TextAlign.right : TextAlign.left,
                  ),
                );
              }),
            ),
          ]
        ],
      ),
    );
  }
}
