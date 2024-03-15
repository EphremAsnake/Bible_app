import 'package:bible_book_app/app/modules/detail/controllers/detail_controller.dart';
import 'package:bible_book_app/app/modules/detail/helpers/detail_helpers.dart';
import 'package:bible_book_app/app/utils/helpers/in_app_web_viewer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AndroidDrawerAd extends StatelessWidget {
  AndroidDrawerAd({super.key});
  final DetailController detailController = Get.find<DetailController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (detailController.apiStateHandler.data!.androidHouseAds[0].houseAd1!
                .openInAppBrowser ==
            true) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => InAppWebViewer(
                  url: detailController
                      .apiStateHandler.data!.androidHouseAds[0].houseAd1!.url),
            ),
          );
        } else {
          if (detailController
                  .apiStateHandler.data!.androidHouseAds[0].houseAd1!.url
                  .contains("http") ==
              true) {
            detailController.openWebBrowser(detailController
                .apiStateHandler.data!.androidHouseAds[0].houseAd1!.url);
          } else {
            DetailHelpers().openStores(
              androidAppId: detailController
                  .apiStateHandler.data!.androidHouseAds[0].houseAd1!.url,
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
              .apiStateHandler.data!.androidHouseAds[0].houseAd1!.image,
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
