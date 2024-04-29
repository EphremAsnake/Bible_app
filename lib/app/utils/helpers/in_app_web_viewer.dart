// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:american_bible/app/modules/home/views/widgets/exit_confirmation_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

import '../../core/shared_controllers/theme_controller.dart';

class InAppWebViewer extends StatefulWidget {
  final String url;
  const InAppWebViewer({
    Key? key,
    required this.url,
  }) : super(key: key);
  @override
  _InAppWebViewerState createState() => _InAppWebViewerState();
}

class _InAppWebViewerState extends State<InAppWebViewer> {
  InAppWebViewController? webViewController;
  final ThemeController themeData = Get.find<ThemeController>();

  String url = "";
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: themeData.themeData.value!.primaryColor,
            statusBarIconBrightness: Brightness.light),
        elevation: 0,
        backgroundColor: themeData.themeData.value!.primaryColor,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: themeData.themeData.value!.whiteColor),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              child: progress < 1.0
                  ? LinearProgressIndicator(value: progress)
                  : Container()),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(0.0),
              child: InAppWebView(
                initialUrlRequest: URLRequest(url: WebUri(widget.url)),
                onWebViewCreated: (InAppWebViewController controller) {
                  webViewController = controller;
                },
                onProgressChanged:
                    (InAppWebViewController controller, int progress) {
                  setState(() {
                    this.progress = progress / 100;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
