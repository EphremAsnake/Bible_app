import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_store/open_store.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/shared_controllers/theme_controller.dart';
import '../../../../utils/helpers/api_state_handler.dart';
import '../../../../utils/helpers/in_app_web_viewer.dart';
import '../../../detail/controllers/detail_controller.dart';

class HomeAD extends StatelessWidget {
  HomeAD({
    super.key,
  });

  final themeData = Get.find<ThemeController>().themeData.value;
  final DetailController detailController = Get.find<DetailController>();
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
    return GetBuilder<DetailController>(
      init: DetailController(),
      initState: (_) {},
      builder: (_) {
        if (detailController.apiStateHandler.apiState == ApiState.loading) {
          return Container(
            padding: const EdgeInsets.all(0),
            height: 25,
            decoration:  BoxDecoration(color: themeData!.backgroundColor),
          );
        } else if (detailController.apiStateHandler.apiState ==
            ApiState.success) {
          if (Platform.isAndroid
              ? detailController
                  .apiStateHandler.data!.androidhouseAds[1].houseAd2!.show
              : detailController
                      .apiStateHandler.data!.ioshouseAds[1].houseAd2!.show ==
                  true) {
            return Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, right: 10.0, top: 10.0, bottom: 15.0),
              child: GestureDetector(
                onTap: () {
                  if (Platform.isAndroid
                      ? detailController.apiStateHandler.data!
                          .androidhouseAds[1].houseAd2!.openInAppBrowser
                      : detailController.apiStateHandler.data!.ioshouseAds[1]
                              .houseAd2!.openInAppBrowser ==
                          true) {
                    Get.to(InAppWebViewer(
                        url: Platform.isAndroid
                            ? detailController.apiStateHandler.data!
                                .androidhouseAds[1].houseAd2!.url
                            : detailController.apiStateHandler.data!
                                .ioshouseAds[1].houseAd2!.url));
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (context) => InAppWebViewer(
                    //         url: detailController.apiStateHandler.data!
                    //             .houseAds[1].houseAd2!.url),
                    //   ),
                    // );
                  } else {
                    Uri.tryParse(Platform.isAndroid
                                ? detailController.apiStateHandler.data!
                                    .androidhouseAds[1].houseAd2!.url
                                : detailController.apiStateHandler.data!
                                    .ioshouseAds[1].houseAd2!.url)!
                            .isAbsolute
                        ? _launchURL(Platform.isAndroid
                            ? detailController.apiStateHandler.data!
                                .androidhouseAds[1].houseAd2!.url
                            : detailController.apiStateHandler.data!
                                .ioshouseAds[1].houseAd2!.url)
                        : Platform.isAndroid
                            ? openUrlAndroid(Platform.isAndroid
                                ? detailController.apiStateHandler.data!
                                    .androidhouseAds[1].houseAd2!.url
                                : detailController.apiStateHandler.data!
                                    .ioshouseAds[1].houseAd2!.url)
                            : openAppStore(Platform.isAndroid
                                ? detailController.apiStateHandler.data!
                                    .androidhouseAds[1].houseAd2!.url
                                : detailController.apiStateHandler.data!
                                    .ioshouseAds[1].houseAd2!.url);
                    // detailController.openWebBrowser(detailController
                    //     .apiStateHandler.data!.houseAds[1].houseAd2!.url);
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: themeData!.cardColor,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow:  [
                      BoxShadow(
                        color: themeData!.shadowColor,
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: Offset(0, 8), // horizontal, vertical offset
                      ),
                      BoxShadow(
                        color: themeData!.shadowColor,
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
                                ? detailController.apiStateHandler.data!
                                    .androidhouseAds[1].houseAd2!.title
                                : detailController.apiStateHandler.data!
                                    .ioshouseAds[1].houseAd2!.title,
                            style:  TextStyle(
                              fontSize:SizerUtil.deviceType == DeviceType.mobile
                                      ? 13
                                      : 7.sp,
                              color: themeData!.verseColor,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: themeData!.primaryColor,
                            border: Border.all(
                              color: themeData!.numbersColor.withOpacity(0.5),
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 2.0, horizontal: 15),
                            child: Text(
                              Platform.isAndroid
                                  ? detailController.apiStateHandler.data!
                                      .androidhouseAds[1].houseAd2!.buttonText
                                  : detailController.apiStateHandler.data!
                                      .ioshouseAds[1].houseAd2!.buttonText,
                              style: TextStyle(
                                color: themeData!.whiteColor,
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
              decoration:
                   BoxDecoration(color: themeData!.backgroundColor),
            );
          }
        } else {
          return Container(
            padding: const EdgeInsets.all(0),
            height: 25,
            decoration:  BoxDecoration(color: themeData!.backgroundColor),
          );
        }
      },
    );
  }
}
