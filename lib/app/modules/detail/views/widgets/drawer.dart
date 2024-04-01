import 'dart:io';
import 'package:bible_book_app/app/core/shared_controllers/data_getter_and_setter_controller.dart';
import 'package:bible_book_app/app/modules/detail/controllers/detail_controller.dart';
import 'package:bible_book_app/app/modules/detail/views/widgets/android_drawer_ad.dart';
import 'package:bible_book_app/app/modules/detail/views/widgets/ios_drawer_ad.dart';
import 'package:bible_book_app/app/modules/home/controllers/home_controller.dart';
import 'package:bible_book_app/app/utils/helpers/api_state_handler.dart';
import 'package:bible_book_app/app/utils/helpers/app_colors.dart';
import 'package:bible_book_app/app/utils/shared_widgets/refresh_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../../../utils/helpers/app_translation.dart';

class CustomDrawer extends StatefulWidget {
  CustomDrawer({
    super.key,
    required this.themeData,
    required this.getterAndSetterController,
  });

  final ThemeDataModel? themeData;
  final DataGetterAndSetter getterAndSetterController;

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final DetailController detailController = Get.find();
  final HomeController homeController = Get.find();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      detailController.defaultTabBarViewInitialIndex == 0
          ? homeController.drawerchScrollController.jumpTo(
              homeController.selectedOldTestamentBookIndex * 45,
            )
          : homeController.drawerchScrollController.jumpTo(
              homeController.selectedNewTestamentBookIndex * 45,
            );
      // detailController.drawerChapterScrollController.jumpTo(
      //   homeController.selectedIndex * 30,
      // );
    });
    // WidgetsBinding.instance!.addPostFrameCallback((_) {
    //   homeController.drawerScrollController.jumpTo(
    //     homeController.selectedNewTestamentBookIndex * 45,
    //   );
    // });
  }

  //  controller
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: widget.themeData!.backgroundColor,
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
                if (Platform.isIOS) {
                  if (detailController.apiStateHandler.data!.iosHouseAds[0]
                          .houseAd1!.show ==
                      true) {
                    return IosDrawerAd();
                  } else {
                    return Container(
                      height: SizerUtil.deviceType == DeviceType.mobile
                          ? 33.h
                          : 23.h,
                      padding: const EdgeInsets.all(0),
                      child: Stack(
                        children: [
                          Image.asset(
                            "assets/images/banner.jpeg",
                            fit: BoxFit.fill,
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
                                    color: widget.themeData!.whiteColor,
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
                  if (detailController.apiStateHandler.data!.androidHouseAds[0]
                          .houseAd1!.show ==
                      true) {
                    return AndroidDrawerAd();
                  } else {
                    return Container(
                      height: SizerUtil.deviceType == DeviceType.mobile
                          ? 33.h
                          : 23.h,
                      padding: const EdgeInsets.all(0),
                      child: Stack(
                        children: [
                          Image.asset(
                            "assets/images/banner.jpeg",
                            fit: BoxFit.fill,
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
                                    color: widget.themeData!.whiteColor,
                                    fontFamily: "Abyssinica",
                                    fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
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
                                color: widget.themeData!.whiteColor,
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
                              color: widget.themeData!.whiteColor,
                            ),
                          );
                        },
                      ),
                    ),
                  );
                } else if (controller.cacheStateHandler.apiState ==
                    ApiState.success) {
                  return Container(
                    color: widget.themeData!.backgroundColor,
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
                                        indicatorColor:
                                            widget.themeData!.primaryColor,
                                        tabs: [
                                          Tab(
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                amh['ot'] ?? 'ot'.tr,
                                                style: TextStyle(
                                                  fontSize:
                                                      SizerUtil.deviceType ==
                                                              DeviceType.mobile
                                                          ? 11.sp
                                                          : 9.sp,
                                                  color: widget
                                                      .themeData?.primaryColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Tab(
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                amh['nt'] ?? 'nt'.tr,
                                                style: TextStyle(
                                                  fontSize:
                                                      SizerUtil.deviceType ==
                                                              DeviceType.mobile
                                                          ? 11.sp
                                                          : 9.sp,
                                                  color: widget
                                                      .themeData?.primaryColor,
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
                                                  initState: (_) {
                                                    // WidgetsBinding.instance!
                                                    //     .addPostFrameCallback(
                                                    //         (_) {
                                                    //   // controller
                                                    //   //     .drawerScrollController
                                                    //   //     .animateTo(
                                                    //   //   // Calculate the scroll position based on the selected index and item height
                                                    //   //   index * itemHeight,
                                                    //   //   duration: Duration(
                                                    //   //       milliseconds: 500),
                                                    //   //   curve: Curves.ease,
                                                    //   // );
                                                    //   controller
                                                    //       .drawerScrollController
                                                    //       .jumpTo(
                                                    //     controller
                                                    //             .selectedOldTestamentBookIndex *
                                                    //         45,
                                                    //   );
                                                    // });
                                                  },
                                                  builder: (_) {
                                                    return ListView.builder(
                                                      controller: controller
                                                          .drawerchScrollController,
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
                                                                ? widget
                                                                    .themeData
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
                                                                  .oldTestamentBook[
                                                                      index]
                                                                  .titleGeez!,
                                                              style: TextStyle(
                                                                color: index ==
                                                                        controller
                                                                            .selectedOldTestamentBookIndex
                                                                    ? widget
                                                                        .themeData
                                                                        ?.whiteColor
                                                                    : widget
                                                                        .themeData
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
                                                                    ? widget
                                                                        .themeData
                                                                        ?.whiteColor
                                                                    : widget
                                                                        .themeData
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
                                                  initState: (_) {
                                                    // WidgetsBinding.instance!
                                                    //     .addPostFrameCallback(
                                                    //         (_) {
                                                    //   controller
                                                    //       .drawerchScrollController
                                                    //       .jumpTo(
                                                    //     controller
                                                    //             .selectedNewTestamentBookIndex *
                                                    //         45,
                                                    //   );
                                                    // });
                                                  },
                                                  builder: (_) {
                                                    return ListView.builder(
                                                      controller: controller
                                                          .drawerchScrollController,
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
                                                                ? widget
                                                                    .themeData
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
                                                                    ? widget
                                                                        .themeData
                                                                        ?.whiteColor
                                                                    : widget
                                                                        .themeData
                                                                        ?.verseColor,
                                                                fontSize: SizerUtil
                                                                            .deviceType ==
                                                                        DeviceType
                                                                            .mobile
                                                                    ? 12.sp
                                                                    : 8.5.sp,
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
                                                                    ? widget
                                                                        .themeData
                                                                        ?.whiteColor
                                                                    : widget
                                                                        .themeData
                                                                        ?.verseColor,
                                                                fontSize: SizerUtil
                                                                            .deviceType ==
                                                                        DeviceType
                                                                            .mobile
                                                                    ? 11.sp
                                                                    : 7.5.sp,
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
                              color: widget.themeData?.primaryColor
                                  .withOpacity(0.5),
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
                                  initState: (_) {
                                    WidgetsBinding.instance!
                                        .addPostFrameCallback((_) {
                                      // controller
                                      //     .drawerScrollController
                                      //     .animateTo(
                                      //   // Calculate the scroll position based on the selected index and item height
                                      //   index * itemHeight,
                                      //   duration: Duration(
                                      //       milliseconds: 500),
                                      //   curve: Curves.ease,
                                      // );

                                      detailController
                                          .drawerChapterScrollController
                                          .jumpTo(
                                        controller.selectedIndex * 30,
                                      );
                                    });
                                  },
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
                                                .drawerChapterScrollController,
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
                                                        ? widget.themeData
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
                                                                ? widget
                                                                    .themeData
                                                                    ?.whiteColor
                                                                : widget
                                                                    .themeData
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
                                                            widget
                                                                .getterAndSetterController
                                                                .selectedVersesAMH
                                                                .clear();
                                                            widget
                                                                .getterAndSetterController
                                                                .selectedVersesAMH
                                                                .addAll(widget
                                                                    .getterAndSetterController
                                                                    .getAMHBookChapters(
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
                                                            widget
                                                                .getterAndSetterController
                                                                .selectedVersesAMH
                                                                .clear();
                                                            widget
                                                                .getterAndSetterController
                                                                .selectedVersesAMH
                                                                .addAll(widget
                                                                    .getterAndSetterController
                                                                    .getAMHBookChapters(
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
