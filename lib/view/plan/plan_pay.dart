import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class PlanPay extends StatelessWidget {
  const PlanPay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse("https://google.com"))),
    );
  }
}
