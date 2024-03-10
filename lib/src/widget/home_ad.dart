import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:holy_bible_app/src/pages/home/logic.dart';
import 'package:holy_bible_app/src/utils/appcolor.dart';
import 'package:open_store/open_store.dart';
import 'package:url_launcher/url_launcher.dart';

import '../pages/webview/inappwebview.dart';
import '../utils/api_state_handler.dart';

class HomeAD extends StatelessWidget {
  HomeAD({
    super.key,
  });

  final HomePageController homepageController = Get.find<HomePageController>();
  Future<void> _launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  void openUrlAndroid(String url) async {
    //!open Playstore
    OpenStore.instance.open(
      androidAppBundleId: url,
    );
  }

  void openAppStore(String appId) async {
    final String appStoreUrl =
        'https://apps.apple.com/app/id$appId?action=write-review';

    _launchURL(appStoreUrl);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(
      init: HomePageController(),
      initState: (_) {},
      builder: (_) {
        if (homepageController.apiStateHandler.apiState == ApiState.loading) {
          return Container(
            padding: const EdgeInsets.all(0),
            height: 25,
            decoration: const BoxDecoration(color: AppColors.white),
          );
        } else if (homepageController.apiStateHandler.apiState ==
            ApiState.success) {
          if (Platform.isAndroid
              ? homepageController
                  .apiStateHandler.data!.androidhouseAds[1].houseAd2!.show
              : homepageController
                      .apiStateHandler.data!.ioshouseAds[1].houseAd2!.show ==
                  true) {
            return Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, right: 10.0, top: 10.0, bottom: 15.0),
              child: GestureDetector(
                onTap: () {
                  if (Platform.isAndroid
                      ? homepageController.apiStateHandler.data!
                          .androidhouseAds[1].houseAd2!.openInAppBrowser
                      : homepageController.apiStateHandler.data!.ioshouseAds[1]
                              .houseAd2!.openInAppBrowser ==
                          true) {
                    Get.to(InAppWebViewPage(
                        webUrl: Platform.isAndroid
                            ? homepageController.apiStateHandler.data!
                                .androidhouseAds[1].houseAd2!.url
                            : homepageController.apiStateHandler.data!
                                .ioshouseAds[1].houseAd2!.url));
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (context) => InAppWebViewer(
                    //         url: homepageController.apiStateHandler.data!
                    //             .houseAds[1].houseAd2!.url),
                    //   ),
                    // );
                  } else {
                    Uri.tryParse(Platform.isAndroid
                                ? homepageController.apiStateHandler.data!
                                    .androidhouseAds[1].houseAd2!.url
                                : homepageController.apiStateHandler.data!
                                    .ioshouseAds[1].houseAd2!.url)!
                            .isAbsolute
                        ? _launchURL(Platform.isAndroid
                            ? homepageController.apiStateHandler.data!
                                .androidhouseAds[1].houseAd2!.url
                            : homepageController.apiStateHandler.data!
                                .ioshouseAds[1].houseAd2!.url)
                        : Platform.isAndroid
                            ? openUrlAndroid(Platform.isAndroid
                                ? homepageController.apiStateHandler.data!
                                    .androidhouseAds[1].houseAd2!.url
                                : homepageController.apiStateHandler.data!
                                    .ioshouseAds[1].houseAd2!.url)
                            : openAppStore(Platform.isAndroid
                                ? homepageController.apiStateHandler.data!
                                    .androidhouseAds[1].houseAd2!.url
                                : homepageController.apiStateHandler.data!
                                    .ioshouseAds[1].houseAd2!.url);
                    // homepageController.openWebBrowser(homepageController
                    //     .apiStateHandler.data!.houseAds[1].houseAd2!.url);
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xffEEEDED),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: Offset(0, 8), // horizontal, vertical offset
                      ),
                      BoxShadow(
                        color: Color(0xffEEEDED),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: Offset(0, -8), // horizontal, vertical offset
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Text(
                            Platform.isAndroid
                                ?homepageController.apiStateHandler.data!.androidhouseAds[1]
                                .houseAd2!.title:homepageController.apiStateHandler.data!.ioshouseAds[1]
                                .houseAd2!.title,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xff7B5533),
                            border: Border.all(
                              color: const Color(0xff7B5533).withOpacity(0.5),
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 2.0, horizontal: 15),
                            child: Text(
                              Platform.isAndroid
                                ?homepageController.apiStateHandler.data!
                                  .androidhouseAds[1].houseAd2!.buttonText:homepageController.apiStateHandler.data!
                                  .ioshouseAds[1].houseAd2!.buttonText,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Container(
              padding: const EdgeInsets.all(0),
              height: 25,
              decoration: const BoxDecoration(color: AppColors.white),
            );
          }
        } else {
          return Container(
            padding: const EdgeInsets.all(0),
            height: 25,
            decoration: const BoxDecoration(color: AppColors.white),
          );
        }
      },
    );
  }
}
