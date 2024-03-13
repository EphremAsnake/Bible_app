import 'dart:io';

import 'package:bible_book_app/app/core/shared_controllers/data_getter_and_setter_controller.dart';
import 'package:bible_book_app/app/modules/detail/controllers/detail_controller.dart';
import 'package:bible_book_app/app/modules/detail/helpers/detail_helpers.dart';
import 'package:bible_book_app/app/modules/home/controllers/home_controller.dart';
import 'package:bible_book_app/app/utils/helpers/api_state_handler.dart';
import 'package:bible_book_app/app/utils/helpers/app_colors.dart';
import 'package:bible_book_app/app/utils/helpers/in_app_web_viewer.dart';
import 'package:bible_book_app/app/utils/shared_widgets/refresh_error_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_store/open_store.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({
    super.key,
    required this.themeData,
    required this.getterAndSetterController,
  });

  final ThemeDataModel? themeData;
  final DataGetterAndSetter getterAndSetterController;
  final DetailController detailController = Get.find();


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
    return Drawer(
      width: SizerUtil.deviceType == DeviceType.mobile ? 90.w : 60.w,
      child: Column(
        children: [
          GetBuilder<DetailController>(
            init: DetailController(),
            initState: (_) {},
            builder: (_) {
              if (detailController.apiStateHandler.apiState ==
                  ApiState.loading) {
                return const SizedBox(
                  height: 40,
                );
              } else if (detailController.apiStateHandler.apiState ==
                  ApiState.success) {
                if (Platform.isAndroid
                    ? detailController
                        .apiStateHandler.data!.androidhouseAds[0].houseAd1!.show
                    : detailController.apiStateHandler.data!.ioshouseAds[0]
                            .houseAd1!.show ==
                        true) {
                  return GestureDetector(
                    onTap: () {
                      if (Platform.isAndroid
                          ? detailController.apiStateHandler.data!
                              .androidhouseAds[0].houseAd1!.openInAppBrowser
                          : detailController.apiStateHandler.data!.ioshouseAds[0]
                                  .houseAd1!.openInAppBrowser ==
                              true) {
                        Get.to(InAppWebViewer(
                            url: Platform.isAndroid
                                ? detailController.apiStateHandler.data!
                                    .androidhouseAds[0].houseAd1!.url
                                : detailController.apiStateHandler.data!
                                    .ioshouseAds[0].houseAd1!.url));
                      } else {
                        Uri.tryParse(Platform.isAndroid
                                    ? detailController.apiStateHandler.data!
                                        .androidhouseAds[0].houseAd1!.url
                                    : detailController.apiStateHandler.data!
                                        .ioshouseAds[0].houseAd1!.url)!
                                .isAbsolute
                            ? _launchURL(Platform.isAndroid
                                ? detailController.apiStateHandler.data!
                                    .androidhouseAds[0].houseAd1!.url
                                : detailController.apiStateHandler.data!
                                    .ioshouseAds[0].houseAd1!.url)
                            : Platform.isAndroid
                                ? openUrlAndroid(Platform.isAndroid
                                    ? detailController.apiStateHandler.data!
                                        .androidhouseAds[0].houseAd1!.url
                                    : detailController.apiStateHandler.data!
                                        .ioshouseAds[0].houseAd1!.url)
                                : openAppStore(Platform.isAndroid
                                    ? detailController.apiStateHandler.data!
                                        .androidhouseAds[0].houseAd1!.url
                                    : detailController.apiStateHandler.data!
                                        .ioshouseAds[0].houseAd1!.url);
                        // DetailHelpers().openStores(
                        //     androidAppId: homeController.apiStateHandler.data!
                        //         .houseAds[0].houseAd1!.url);
                      }
                    },
                    child: Container(
                      height: SizerUtil.deviceType == DeviceType.mobile
                          ? 33.h
                          : 23.h,
                      width: SizerUtil.deviceType == DeviceType.mobile
                          ? 90.w
                          : 70.w,
                      padding: const EdgeInsets.all(0),
                      child: CachedNetworkImage(
                        imageUrl: Platform.isAndroid
                            ? detailController.apiStateHandler.data!
                                .androidhouseAds[0].houseAd1!.image
                            : detailController.apiStateHandler.data!
                                .ioshouseAds[0].houseAd1!.image,
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
                } else {
                  return Container(
                    height:
                        SizerUtil.deviceType == DeviceType.mobile ? 33.h : 23.h,
                    padding: const EdgeInsets.all(0),
                    child: Stack(
                      children: [
                        Image.asset(
                          "assets/images/banner.jpeg",
                          fit: BoxFit.fill,
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            color: Colors.black.withOpacity(0.5),
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              detailController.drawerQuote,
                              style: TextStyle(
                                  color: themeData!.whiteColor,
                                  fontFamily: "Abyssinica",
                                  fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              } else {
                return Container(
                  height:
                      SizerUtil.deviceType == DeviceType.mobile ? 33.h : 23.h,
                  padding: const EdgeInsets.all(0),
                  child: Stack(
                    children: [
                      Image.asset(
                        "assets/images/banner.jpeg",
                        fit: BoxFit.fitHeight,
                        height: SizerUtil.deviceType == DeviceType.mobile
                            ? 33.h
                            : 23.h,
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          color: Colors.black.withOpacity(0.5),
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            detailController.drawerQuote,
                            style: TextStyle(
                                color: themeData!.whiteColor,
                                fontFamily: "Abyssinica",
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
          Expanded(
            child: GetBuilder<HomeController>(
              init: HomeController(),
              initState: (_) {},
              builder: (controller) {
                if (controller.cacheStateHandler.apiState == ApiState.loading) {
                  return SizedBox(
                    height: 400,
                    width: 220,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 5,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 2),
                            child: Container(
                              width: double.infinity,
                              height: 80,
                              color: themeData!.whiteColor,
                            ),
                          );
                        },
                      ),
                    ),
                  );
                } else if (controller.cacheStateHandler.apiState ==
                    ApiState.success) {
                  return Container(
                    color: themeData!.backgroundColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: SizedBox(
                                width: SizerUtil.deviceType == DeviceType.mobile
                                    ? 60.w
                                    : 40.w,
                                child: DefaultTabController(
                                  initialIndex: detailController
                                      .defaultTabBarViewInitialIndex,
                                  length: 2, // Number of tabs
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TabBar(
                                        indicatorColor: themeData!.primaryColor,
                                        tabs: [
                                          Tab(
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                'ot'.tr,
                                                style: TextStyle(
                                                  fontSize:
                                                      SizerUtil.deviceType ==
                                                              DeviceType.mobile
                                                          ? 11.sp
                                                          : 9.sp,
                                                  color:
                                                      themeData?.primaryColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Tab(
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                'nt'.tr,
                                                style: TextStyle(
                                                  fontSize:
                                                      SizerUtil.deviceType ==
                                                              DeviceType.mobile
                                                          ? 11.sp
                                                          : 9.sp,
                                                  color:
                                                      themeData?.primaryColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: SizedBox(
                                          width: SizerUtil.deviceType ==
                                                  DeviceType.mobile
                                              ? 80.w
                                              : 60.w,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 0, left: 3, bottom: 0),
                                            child: TabBarView(
                                              children: [
                                                GetBuilder<HomeController>(
                                                  init: HomeController(),
                                                  initState: (_) {},
                                                  builder: (_) {
                                                    return ListView.builder(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10,
                                                              bottom: 15),
                                                      itemCount: controller
                                                          .oldTestamentBook
                                                          .length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: index ==
                                                                    controller
                                                                        .selectedOldTestamentBookIndex
                                                                ? themeData
                                                                    ?.lightPrimary
                                                                : null,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          child: ListTile(
                                                            dense: true,
                                                            visualDensity:
                                                                const VisualDensity(
                                                              vertical: -3,
                                                            ),
                                                            title: Text(
                                                              controller
                                                                  .oldTestamentBook[
                                                                      index]
                                                                  .titleGeez!,
                                                              style: TextStyle(
                                                                color: index ==
                                                                        controller
                                                                            .selectedOldTestamentBookIndex
                                                                    ? themeData
                                                                        ?.whiteColor
                                                                    : themeData
                                                                        ?.verseColor,
                                                                fontSize: SizerUtil
                                                                            .deviceType ==
                                                                        DeviceType
                                                                            .mobile
                                                                    ? 12.sp
                                                                    : 8.5.sp,
                                                                fontWeight: index ==
                                                                        controller
                                                                            .selectedOldTestamentBookIndex
                                                                    ? FontWeight
                                                                        .bold
                                                                    : FontWeight
                                                                        .normal,
                                                              ),
                                                            ),
                                                            subtitle: Text(
                                                              controller
                                                                  .oldTestamentBook[
                                                                      index]
                                                                  .title!,
                                                              style: TextStyle(
                                                                color: index ==
                                                                        controller
                                                                            .selectedOldTestamentBookIndex
                                                                    ? themeData
                                                                        ?.whiteColor
                                                                    : themeData
                                                                        ?.verseColor,
                                                                fontSize: SizerUtil
                                                                            .deviceType ==
                                                                        DeviceType
                                                                            .mobile
                                                                    ? 11.sp
                                                                    : 7.5.sp,
                                                                fontWeight: index ==
                                                                        controller
                                                                            .selectedOldTestamentBookIndex
                                                                    ? FontWeight
                                                                        .bold
                                                                    : FontWeight
                                                                        .normal,
                                                              ),
                                                            ),
                                                            onTap: () {
                                                              controller
                                                                  .updateOldTestamentSelectedBookIndex(
                                                                      index);
                                                              detailController
                                                                      .isSelectingBook =
                                                                  true;

                                                              detailController
                                                                  .update();
                                                            },
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                ),
                                                GetBuilder<HomeController>(
                                                  init: HomeController(),
                                                  initState: (_) {},
                                                  builder: (_) {
                                                    return ListView.builder(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10,
                                                              bottom: 15),
                                                      itemCount: controller
                                                          .newTestamentBook
                                                          .length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: index ==
                                                                    controller
                                                                        .selectedNewTestamentBookIndex
                                                                ? themeData
                                                                    ?.lightPrimary
                                                                : null,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          child: ListTile(
                                                            dense: true,
                                                            visualDensity:
                                                                const VisualDensity(
                                                                    vertical:
                                                                        -3),
                                                            title: Text(
                                                              controller
                                                                  .newTestamentBook[
                                                                      index]
                                                                  .titleGeez!,
                                                              style: TextStyle(
                                                                color: index ==
                                                                        controller
                                                                            .selectedNewTestamentBookIndex
                                                                    ? themeData
                                                                        ?.whiteColor
                                                                    : themeData
                                                                        ?.verseColor,
                                                                fontSize: 16,
                                                                fontWeight: index ==
                                                                        controller
                                                                            .selectedNewTestamentBookIndex
                                                                    ? FontWeight
                                                                        .bold
                                                                    : FontWeight
                                                                        .normal,
                                                              ),
                                                            ),
                                                            subtitle: Text(
                                                              controller
                                                                  .newTestamentBook[
                                                                      index]
                                                                  .title!,
                                                              style: TextStyle(
                                                                color: index ==
                                                                        controller
                                                                            .selectedNewTestamentBookIndex
                                                                    ? themeData
                                                                        ?.whiteColor
                                                                    : themeData
                                                                        ?.verseColor,
                                                                fontSize: 14,
                                                                fontWeight: index ==
                                                                        controller
                                                                            .selectedNewTestamentBookIndex
                                                                    ? FontWeight
                                                                        .bold
                                                                    : FontWeight
                                                                        .normal,
                                                              ),
                                                            ),
                                                            onTap: () {
                                                              controller
                                                                  .updateNewTestamentSelectedBookIndex(
                                                                      index);
                                                              detailController
                                                                      .isSelectingBook =
                                                                  true;
                                                              detailController
                                                                  .update();
                                                            },
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Visibility(
                          visible: controller.selectedOldTestamentBookIndex !=
                                  -1 ||
                              controller.selectedNewTestamentBookIndex != -1,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 0.sp, horizontal: 0),
                            child: VerticalDivider(
                              width: 1,
                              color: themeData?.primaryColor.withOpacity(0.5),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: controller.selectedOldTestamentBookIndex !=
                                  -1 ||
                              controller.selectedNewTestamentBookIndex != -1,
                          child: SizedBox(
                            width: SizerUtil.deviceType == DeviceType.mobile
                                ? 24.w
                                : 15.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 28),
                                GetBuilder<HomeController>(
                                  init: HomeController(),
                                  initState: (_) {},
                                  builder: (_) {
                                    int bookChapters = 0;

                                    if (controller
                                            .selectedOldTestamentBookIndex !=
                                        -1) {
                                      bookChapters = controller
                                          .oldTestamentBook[controller
                                              .selectedOldTestamentBookIndex]
                                          .chapters!;
                                    } else if (controller
                                            .selectedNewTestamentBookIndex !=
                                        -1) {
                                      bookChapters = controller
                                          .newTestamentBook[controller
                                              .selectedNewTestamentBookIndex]
                                          .chapters!;
                                    }

                                    List<int> chapters = List.generate(
                                        bookChapters, (index) => index + 1);
                                    return Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: SizedBox(
                                          width: 30.w,
                                          child: ListView.builder(
                                            controller: detailController
                                                .drawerScrollController,
                                            shrinkWrap: true,
                                            itemCount: chapters.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: index ==
                                                            controller
                                                                .selectedIndex
                                                        ? themeData
                                                            ?.lightPrimary
                                                        : null,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: ListTile(
                                                    dense: false,
                                                    visualDensity:
                                                        const VisualDensity(
                                                            vertical: -4),
                                                    title: Center(
                                                      child: Text(
                                                        chapters[index]
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: index ==
                                                                    controller
                                                                        .selectedIndex
                                                                ? themeData
                                                                    ?.whiteColor
                                                                : themeData
                                                                    ?.verseColor,
                                                            fontSize: SizerUtil
                                                                        .deviceType ==
                                                                    DeviceType
                                                                        .mobile
                                                                ? 12.sp
                                                                : 8.5.sp,
                                                            fontWeight: index ==
                                                                    controller
                                                                        .selectedIndex
                                                                ? FontWeight
                                                                    .bold
                                                                : FontWeight
                                                                    .normal),
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      controller
                                                          .updateSelectedIndex(
                                                              index);
                                                      Future.delayed(
                                                        const Duration(
                                                            milliseconds: 100),
                                                        () {
                                                          if (controller
                                                                  .selectedNewTestamentBookIndex !=
                                                              -1) {
                                                            getterAndSetterController
                                                                .selectedVersesAMH
                                                                .clear();
                                                            getterAndSetterController
                                                                .selectedVersesAMH
                                                                .addAll(getterAndSetterController.getAMHBookChapters(
                                                                    controller
                                                                        .newTestamentBook[controller
                                                                            .selectedNewTestamentBookIndex]
                                                                        .id!,
                                                                    chapters[
                                                                        index],
                                                                    controller
                                                                        .versesAMH));

                                                            int page = detailController
                                                                .navigateToSpecificBookDetailView(
                                                                    controller
                                                                        .newTestamentBook[controller
                                                                            .selectedNewTestamentBookIndex]
                                                                        .id!,
                                                                    chapters[
                                                                        index]);
                                                            detailController
                                                                .pageController
                                                                ?.jumpToPage(
                                                                    page);
                                                            detailController
                                                                .update();
                                                          } else if (controller
                                                                  .selectedOldTestamentBookIndex !=
                                                              -1) {
                                                            getterAndSetterController
                                                                .selectedVersesAMH
                                                                .clear();
                                                            getterAndSetterController
                                                                .selectedVersesAMH
                                                                .addAll(getterAndSetterController.getAMHBookChapters(
                                                                    controller
                                                                        .oldTestamentBook[controller
                                                                            .selectedOldTestamentBookIndex]
                                                                        .id!,
                                                                    chapters[
                                                                        index],
                                                                    controller
                                                                        .versesAMH));
                                                          }
                                                          int page = detailController
                                                              .navigateToSpecificBookDetailView(
                                                                  controller
                                                                      .oldTestamentBook[
                                                                          controller
                                                                              .selectedOldTestamentBookIndex]
                                                                      .id!,
                                                                  chapters[
                                                                      index]);
                                                          detailController
                                                              .pageController
                                                              ?.jumpToPage(
                                                                  page);
                                                          detailController
                                                              .update();
                                                          Get.toNamed(
                                                              "/detail");
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (controller.cacheStateHandler.apiState ==
                    ApiState.error) {
                  return RefreshErrorWidget(
                    showBackToHomeButton: false,
                    assetImage: "assets/images/error.png",
                    errorMessage:
                        "No internet connection, please check your internet connection and try again.",
                    onRefresh: () async {
                      controller.readBibleData();
                      controller.update();
                    },
                  );
                } else {
                  return RefreshErrorWidget(
                    showBackToHomeButton: false,
                    assetImage: "assets/images/error.png",
                    errorMessage:
                        "No internet connection, please check your internet connection and try again.",
                    onRefresh: () async {
                      controller.readBibleData();
                      controller.update();
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
