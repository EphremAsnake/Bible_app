import 'package:bible_book_app/app/core/shared_controllers/theme_controller.dart';
import 'package:bible_book_app/app/modules/detail/controllers/detail_controller.dart';
import 'package:bible_book_app/app/modules/detail/helpers/detail_helpers.dart';
import 'package:bible_book_app/app/utils/helpers/api_state_handler.dart';
import 'package:bible_book_app/app/utils/helpers/in_app_web_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class IosHomeAD extends StatelessWidget {
  IosHomeAD({
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
          return Container(
            padding: const EdgeInsets.all(0),
            height: 25,
            decoration: BoxDecoration(color: themeData!.whiteColor),
          );
        } else if (detailController.apiStateHandler.apiState ==
            ApiState.success) {
          if (detailController
                  .apiStateHandler.data!.iosHouseAds[1].houseAd2!.show ==
              true) {
            return Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, right: 10.0, top: 10.0, bottom: 15.0),
              child: GestureDetector(
                onTap: () {
                  if (detailController.apiStateHandler.data!.iosHouseAds[1]
                          .houseAd2!.openInAppBrowser ==
                      true) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => InAppWebViewer(
                            url: detailController.apiStateHandler.data!
                                .iosHouseAds[1].houseAd2!.url),
                      ),
                    );
                  } else {
                    if (detailController
                            .apiStateHandler.data!.iosHouseAds[1].houseAd2!.url
                            .contains("http") ==
                        true) {
                      detailController.openWebBrowser(detailController
                          .apiStateHandler.data!.iosHouseAds[1].houseAd2!.url);
                    } else {
                      DetailHelpers().openStores(
                        iOSAppId: detailController
                            .apiStateHandler.data!.iosHouseAds[1].houseAd2!.url,
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
                                .iosHouseAds[1].houseAd2!.title,
                            style: TextStyle(
                              fontSize:
                                  SizerUtil.deviceType == DeviceType.mobile
                                      ? 13
                                      : 7.sp,
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
                              detailController.apiStateHandler.data!
                                  .iosHouseAds[1].houseAd2!.buttonText,
                              style: TextStyle(
                                color: Colors.white,
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
            return Container(
              padding: const EdgeInsets.all(0),
              height: 5,
              decoration: BoxDecoration(color: themeData!.whiteColor),
            );
          }
        } else {
          return Container(
            padding: const EdgeInsets.all(0),
            height: 5,
            decoration: BoxDecoration(color: themeData!.whiteColor),
          );
        }
      },
    );
  }
}
