import 'package:spanish_bible/app/core/shared_controllers/theme_controller.dart';
import 'package:spanish_bible/app/modules/detail/controllers/detail_controller.dart';
import 'package:spanish_bible/app/modules/detail/helpers/detail_helpers.dart';
import 'package:spanish_bible/app/utils/helpers/api_state_handler.dart';
import 'package:spanish_bible/app/utils/helpers/in_app_web_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AndroidHomeAD extends StatelessWidget {
  AndroidHomeAD({
    super.key,
  });
  final themeData = Get.find<ThemeController>().themeData.value;
  final DetailController detailController = Get.find<DetailController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailController>(
      init: DetailController(),
      initState: (_) {},
      builder: (_) {
        if (detailController.apiStateHandler.apiState == ApiState.loading) {
          return const SizedBox.shrink();
        } else if (detailController.apiStateHandler.apiState ==
            ApiState.success) {
          if (detailController
                  .apiStateHandler.data!.androidHouseAds[1].houseAd2!.show ==
              true) {
            return Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, right: 10.0, top: 10.0, bottom: 15.0),
              child: GestureDetector(
                onTap: () {
                  if (detailController.apiStateHandler.data!.androidHouseAds[1]
                          .houseAd2!.openInAppBrowser ==
                      true) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => InAppWebViewer(
                            url: detailController.apiStateHandler.data!
                                .androidHouseAds[1].houseAd2!.url),
                      ),
                    );
                  } else {
                    if (detailController.apiStateHandler.data!
                            .androidHouseAds[1].houseAd2!.url
                            .contains("http") ==
                        true) {
                      detailController.openWebBrowser(detailController
                          .apiStateHandler
                          .data!
                          .androidHouseAds[1]
                          .houseAd2!
                          .url);
                    } else {
                      DetailHelpers().openStores(
                        androidAppId: detailController.apiStateHandler.data!
                            .androidHouseAds[1].houseAd2!.url,
                      );
                    }
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
                            detailController.apiStateHandler.data!
                                .androidHouseAds[1].houseAd2!.title,
                            style: TextStyle(
                              fontSize:
                                  SizerUtil.deviceType == DeviceType.mobile
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
                              detailController.apiStateHandler.data!
                                  .androidHouseAds[1].houseAd2!.buttonText,
                              style: TextStyle(
                                color: themeData!.whiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    SizerUtil.deviceType == DeviceType.mobile
                                        ? 13
                                        : 7.sp,
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
            return const SizedBox.shrink();
          }
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
