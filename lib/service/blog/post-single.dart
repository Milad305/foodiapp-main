import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:html/dom.dart' as dom;
import 'package:salamatiman/getx/blog/blog-getter.dart';
import 'package:salamatiman/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class PostSingle extends GetView<PostGetter> {
  final postID;
  PostSingle({Key? key, required this.postID}) : super(key: key) {
    controller.getSingle(postId: postID.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Constants.primaryColor,
        surfaceTintColor: Constants.primaryColor,
        elevation: 10,
      ),
      body: Obx(() {
        final singlePost = controller.singlePost.isEmpty;
        return singlePost
            ? Center(
                child: SpinKitThreeBounce(
                  color: Colors.black45,
                  size: 17.sp,
                ),
              )
            : SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 6),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            child: Image.network(
                                "${controller.singlePost[0]["preview"]}"),
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Container(
                          width: double.infinity,
                          child: Text(
                            "${controller.singlePost[0]["post_title"]}",
                            style: TextStyle(fontSize: 19),
                          ),
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        Html(
                          data:
                              """${controller.singlePost[0]["post_content"]}""",
                          onLinkTap: (String? url,
                              RenderContext context,
                              Map<String, String> attributes,
                              dom.Element? element) {
                            _launchUrl(url);
                          },
                          style: {
                            "*": Style(
                              fontFamily: Constants.primaryFontFamilyAdad,
                            ),
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
      }),
    );
  }

  void _launchUrl(_url) async {
    if (!await launchUrl(Uri.parse(_url), mode: LaunchMode.externalApplication))
      throw 'Could not launch $_url';
  }
}
