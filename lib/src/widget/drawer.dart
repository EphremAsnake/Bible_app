import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:holy_bible_app/src/pages/home/homepage.dart';
import 'package:holy_bible_app/src/pages/home/logic.dart';
import 'package:open_store/open_store.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/datagetterandsetter.dart';
import '../controller/maincontroller.dart';
import '../pages/webview/inappwebview.dart';
import '../utils/api_state_handler.dart';
import '../utils/appcolor.dart';
import '../utils/Strings.dart';
import 'refresh_error_widget.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({
    super.key,
    required this.getterAndSetterController,
  });

  final DataGetterAndSetter getterAndSetterController;
  final HomePageController homeController = Get.find();

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
      width: 90.w,
      child: Column(
        //physics: const NeverScrollableScrollPhysics(),
        children: [
          GetBuilder<HomePageController>(
            init: HomePageController(),
            initState: (_) {},
            builder: (_) {
              if (homeController.apiStateHandler.apiState == ApiState.loading) {
                return const SizedBox(
                  height: 40,
                );
              } else if (homeController.apiStateHandler.apiState ==
                  ApiState.success) {
                if (homeController
                        .apiStateHandler.data!.houseAds[0].houseAd1!.show ==
                    true) {
                  return GestureDetector(
                    onTap: () {
                      if (homeController.apiStateHandler.data!.houseAds[0]
                              .houseAd1!.openInAppBrowser ==
                          true) {
                        Get.to(InAppWebViewPage(
                            webUrl: homeController.apiStateHandler.data!
                                .houseAds[0].houseAd1!.url));
                      } else {
                        Uri.tryParse(homeController.apiStateHandler.data!
                                    .houseAds[0].houseAd1!.url)
                                !.isAbsolute
                            ? _launchURL(homeController.apiStateHandler.data!
                                .houseAds[0].houseAd1!.url)
                            : Platform.isAndroid
                                ? openUrlAndroid(homeController.apiStateHandler
                                    .data!.houseAds[0].houseAd1!.url)
                                : openAppStore(homeController.apiStateHandler
                                    .data!.houseAds[0].houseAd1!.url);
                        // DetailHelpers().openStores(
                        //     androidAppId: homeController.apiStateHandler.data!
                        //         .houseAds[0].houseAd1!.url);
                      }
                    },
                    child: Container(
                      height: 25.h,
                      width: 90.w,
                      padding: const EdgeInsets.all(0),
                      child: CachedNetworkImage(
                        imageUrl: homeController
                            .apiStateHandler.data!.houseAds[0].houseAd1!.image,
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
                              homeController.drawerQuote,
                              style: const TextStyle(
                                  color: AppColors.white,
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
                return const SizedBox(
                  height: 40,
                );
              }
            },
          ),
          Expanded(
            child: GetBuilder<MainController>(
              init: MainController(),
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
                              color: AppColors.white,
                            ),
                          );
                        },
                      ),
                    ),
                  );
                } else if (controller.cacheStateHandler.apiState ==
                    ApiState.success) {
                  return Container(
                    color: AppColors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: SizedBox(
                                width: 60.w,
                                child: DefaultTabController(
                                  initialIndex: homeController
                                      .defaultTabBarViewInitialIndex,
                                  length: 2, // Number of tabs
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      
                                      TabBar(
                                        indicatorColor: AppColors.primaryColor,
                                        tabs: [
                                          Tab(
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                'ot'.tr,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 10.sp,
                                                  color: AppColors.primaryColor,
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
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 10.sp,
                                                  color: AppColors.primaryColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: SizedBox(
                                          width: 80.w,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 3, left: 3, bottom: 0),
                                            child: TabBarView(
                                              children: [
                                                GetBuilder<MainController>(
                                                  init: MainController(),
                                                  initState: (_) {},
                                                  builder: (_) {
                                                    return ListView.builder(
                                                      itemCount: controller
                                                          .oldTestamentBook
                                                          .length,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 30,
                                                              top: 15),
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: index ==
                                                                    controller
                                                                        .selectedOldTestamentBookIndex
                                                                ? AppColors
                                                                    .thcolor
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
                                                            //!Other Language OT Title
                                                            title: Text(
                                                              getterAndSetterController
                                                                      .otherLanguageOT[
                                                                  index],
                                                              style: TextStyle(
                                                                color: index ==
                                                                        controller
                                                                            .selectedOldTestamentBookIndex
                                                                    ? AppColors
                                                                        .white
                                                                    : AppColors
                                                                        .black,
                                                                fontSize: 17,
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
                                                                    ? AppColors
                                                                        .white
                                                                    : AppColors
                                                                        .black,
                                                                fontSize: 13,
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
                                                              homeController
                                                                      .isSelectingBook =
                                                                  true;

                                                              homeController
                                                                  .update();
                                                            },
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                ),
                                                GetBuilder<MainController>(
                                                  init: MainController(),
                                                  initState: (_) {},
                                                  builder: (_) {
                                                    return ListView.builder(
                                                      itemCount: controller
                                                          .newTestamentBook
                                                          .length,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 30,
                                                              top: 15),
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: index ==
                                                                    controller
                                                                        .selectedNewTestamentBookIndex
                                                                ? AppColors
                                                                    .thcolor
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

                                                            //!Other Language NT
                                                            title: Text(
                                                              getterAndSetterController
                                                                      .otherLanguageNT[
                                                                  index],
                                                              style: TextStyle(
                                                                color: index ==
                                                                        controller
                                                                            .selectedNewTestamentBookIndex
                                                                    ? AppColors
                                                                        .white
                                                                    : AppColors
                                                                        .black,
                                                                fontSize: 17,
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
                                                                    ? AppColors
                                                                        .white
                                                                    : AppColors
                                                                        .black,
                                                                fontSize: 13,
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
                                                              homeController
                                                                      .isSelectingBook =
                                                                  true;
                                                              homeController
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
                            child: const VerticalDivider(
                              width: 1,
                              color: AppColors.thcolor,
                            ),
                          ),
                        ),
                        Visibility(
                          visible: controller.selectedOldTestamentBookIndex !=
                                  -1 ||
                              controller.selectedNewTestamentBookIndex != -1,
                          child: SizedBox(
                            width: 24.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 50),
                                GetBuilder<MainController>(
                                  init: MainController(),
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
                                            controller: homeController
                                                .drawerScrollController,
                                            shrinkWrap: true,
                                            padding: const EdgeInsets.only(
                                                bottom: 30),
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
                                                        ? AppColors.thcolor
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
                                                                ? AppColors
                                                                    .white
                                                                : AppColors
                                                                    .black,
                                                            fontSize: index ==
                                                                    controller
                                                                        .selectedIndex
                                                                ? 12.sp
                                                                : 12.sp,
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

                                                            int page = homeController
                                                                .navigateToSpecificBookDetailView(
                                                                    controller
                                                                        .newTestamentBook[controller
                                                                            .selectedNewTestamentBookIndex]
                                                                        .id!,
                                                                    chapters[
                                                                        index]);
                                                            homeController
                                                                .pageController
                                                                ?.jumpToPage(
                                                                    page);
                                                            homeController
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
                                                          int page = homeController
                                                              .navigateToSpecificBookDetailView(
                                                                  controller
                                                                      .oldTestamentBook[
                                                                          controller
                                                                              .selectedOldTestamentBookIndex]
                                                                      .id!,
                                                                  chapters[
                                                                      index]);
                                                          homeController
                                                              .pageController
                                                              ?.jumpToPage(
                                                                  page);
                                                          homeController
                                                              .update();
                                                          Get.to(HomePage());
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
