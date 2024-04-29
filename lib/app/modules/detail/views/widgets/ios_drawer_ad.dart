import 'package:american_bible/app/modules/detail/controllers/detail_controller.dart';
import 'package:american_bible/app/modules/detail/helpers/detail_helpers.dart';
import 'package:american_bible/app/utils/helpers/in_app_web_viewer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class IosDrawerAd extends StatelessWidget {
  IosDrawerAd({super.key});
  final DetailController detailController = Get.find<DetailController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (detailController.apiStateHandler.data!.iosHouseAds[0].houseAd1!
                .openInAppBrowser ==
            true) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => InAppWebViewer(
                  url: detailController
                      .apiStateHandler.data!.iosHouseAds[0].houseAd1!.url),
            ),
          );
        } else {
          if (detailController
                  .apiStateHandler.data!.iosHouseAds[0].houseAd1!.url
                  .contains("http") ==
              true) {
            detailController.openWebBrowser(detailController
                .apiStateHandler.data!.iosHouseAds[0].houseAd1!.url);
          } else {
            DetailHelpers().openStores(
              iOSAppId: detailController
                  .apiStateHandler.data!.iosHouseAds[0].houseAd1!.url,
            );
          }
        }
      },
      child: Container(
        height: SizerUtil.deviceType == DeviceType.mobile ? 33.h : 23.h,
        width: SizerUtil.deviceType == DeviceType.mobile ? 90.w : 70.w,
        padding: const EdgeInsets.all(0),
        child: CachedNetworkImage(
          imageUrl: detailController
              .apiStateHandler.data!.iosHouseAds[0].houseAd1!.image,
          fit: BoxFit.fill,
          placeholder: (context, url) => const SizedBox(
            height: 40,
          ),
          errorWidget: (context, url, error) => const SizedBox(
            height: 40,
          ),
        ),
      ),
    );
  }
}
