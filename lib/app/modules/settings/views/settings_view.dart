import 'package:spanish_bible/app/core/shared_controllers/theme_controller.dart';
import 'package:spanish_bible/app/modules/detail/controllers/detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../utils/helpers/hex_color_helper.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  SettingsView({Key? key}) : super(key: key);
  final ThemeController themeData = Get.find<ThemeController>();
  final DetailController detailController = Get.find<DetailController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: themeData.themeData.value!.backgroundColor,
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: themeData.themeData.value!.primaryColor,
              statusBarIconBrightness: Brightness.light),
          elevation: 0,
          backgroundColor: themeData.themeData.value!.primaryColor,
          centerTitle: false,
          title: Text(
            'settings'.tr,
            style: TextStyle(
              color: themeData.themeData.value!.whiteColor,
            ),
          ),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back,
                color: themeData.themeData.value!.whiteColor),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: themeData.themeData.value!.cardColor,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: themeData.themeData.value!.shadowColor,
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: Offset(0, 8), // horizontal, vertical offset
                    ),
                    BoxShadow(
                      color: themeData.themeData.value!.shadowColor,
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: Offset(0, -8), // horizontal, vertical offset
                    ),
                  ],
                ),
                child: ListTile(
                  onTap: () {
                    if (Get.locale.toString() == "es_SPN") {
                      detailController.saveLocale('en_US');
                      Get.updateLocale(const Locale('en', 'US'));
                      Get.snackbar(
                        'Info',
                        'App Language Changed To English',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    } else {
                      Get.updateLocale(const Locale('es', 'SPN'));
                      detailController.saveLocale('es_SPN');
                      Get.snackbar(
                        'Información',
                        'Idioma de la aplicación cambiado a español',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    }
                  },
                  leading: Icon(
                    Icons.translate,
                    color: themeData.themeData.value!.verseColor,
                  ),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: themeData.themeData.value!.verseColor,
                    size: 30,
                  ),
                  title: Text(
                    "change_language".tr,
                    style: TextStyle(
                        color: themeData.themeData.value!.verseColor,
                        fontSize: SizerUtil.deviceType == DeviceType.mobile
                            ? 12.5.sp
                            : 9.sp),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: themeData.themeData.value!.cardColor,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: themeData.themeData.value!.shadowColor,
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: Offset(0, 8), // horizontal, vertical offset
                      ),
                      BoxShadow(
                        color: themeData.themeData.value!.shadowColor,
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: Offset(0, -8), // horizontal, vertical offset
                      ),
                    ],
                  ),
                  child: ListTile(
                    onTap: () {
                      showFontSizeBottomSheet(context);
                    },
                    leading: Icon(
                      Icons.font_download,
                      color: themeData.themeData.value!.verseColor,
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: themeData.themeData.value!.verseColor,
                      size: 30,
                    ),
                    title: Text(
                      "font_size".tr,
                      style: TextStyle(
                          color: themeData.themeData.value!.verseColor,
                          fontSize: SizerUtil.deviceType == DeviceType.mobile
                              ? 12.5.sp
                              : 9.sp),
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: themeData.themeData.value!.cardColor,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: themeData.themeData.value!.shadowColor,
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: Offset(0, 8), // horizontal, vertical offset
                    ),
                    BoxShadow(
                      color: themeData.themeData.value!.shadowColor,
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: Offset(0, -8), // horizontal, vertical offset
                    ),
                  ],
                ),
                child: ListTile(
                  onTap: () {
                    showThemeConfigBottomSheet(context);
                  },
                  leading: Icon(
                    Icons.color_lens_outlined,
                    color: themeData.themeData.value!.verseColor,
                  ),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: themeData.themeData.value!.verseColor,
                    size: 30,
                  ),
                  title: Text(
                    "theme".tr,
                    style: TextStyle(
                        color: themeData.themeData.value!.verseColor,
                        fontSize: SizerUtil.deviceType == DeviceType.mobile
                            ? 12.5.sp
                            : 9.sp),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showFontSizeBottomSheet(BuildContext context) {
  final DetailController detailController = Get.find<DetailController>();
  final themeData = Get.find<ThemeController>().themeData.value;
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (BuildContext context) {
      return GetBuilder<DetailController>(
        init: DetailController(),
        initState: (_) {},
        builder: (_) {
          return Container(
            decoration: BoxDecoration(
              color: themeData!.backgroundColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "font_size".tr,
                    style: TextStyle(
                        fontSize: SizerUtil.deviceType == DeviceType.mobile
                            ? 12.5.sp
                            : 9.sp,
                        color: themeData.verseColor),
                  ),
                ),
                Slider(
                  inactiveColor: themeData.lightPrimary.withOpacity(0.3),
                  activeColor: themeData.primaryColor,
                  value: detailController.fontSize,
                  onChanged: (value) async {
                    await detailController.updateFontSize(value);
                    // await detailController.updateChapterFontSize(value);
                    detailController.update();
                  },
                  min: SizerUtil.deviceType == DeviceType.mobile ? 10.0 : 8,
                  max: SizerUtil.deviceType == DeviceType.mobile ? 20 : 14,
                  label: detailController.fontSize.toString(),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

void showThemeConfigBottomSheet(BuildContext context) {
  final themeController = Get.find<ThemeController>();
  final ThemeController themeData = Get.find<ThemeController>();
  showModalBottomSheet(
    barrierColor: Colors.transparent,
    context: context,
    builder: (BuildContext context) {
      return GetBuilder<DetailController>(
        init: DetailController(),
        initState: (_) {},
        builder: (_) {
          return Container(
            decoration: BoxDecoration(
              color: themeData.themeData.value!.backgroundColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      "theme".tr,
                      style: TextStyle(
                          fontSize: SizerUtil.deviceType == DeviceType.mobile
                              ? 12.5.sp
                              : 9.sp),
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: Divider(),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: GestureDetector(
                            onTap: () {
                              themeController.getLightThemeData();
                              themeController.update();
                            },
                            child: Container(
                              width: 60,
                              height: 40,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 192, 192, 192)),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: const Center(
                                  child: Text(
                                "Default",
                                style: TextStyle(color: Colors.black),
                              )),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: GestureDetector(
                            onTap: () {
                              themeController.getAmberThemeData();
                              themeController.update();
                            },
                            child: Container(
                              width: 60,
                              height: 40,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 192, 192, 192)),
                                  color:
                                      const Color.fromARGB(255, 238, 225, 206),
                                  borderRadius: BorderRadius.circular(5)),
                              child: const Center(child: Text("Amber")),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            themeController.getGoldThemeData();
                            themeController.update();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Container(
                              width: 60,
                              height: 40,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 192, 192, 192)),
                                  color:
                                      const Color.fromARGB(255, 247, 222, 184),
                                  borderRadius: BorderRadius.circular(5)),
                              child: const Center(child: Text("Gold")),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: GestureDetector(
                            onTap: () {
                              themeController.getTealThemeData();
                              themeController.update();
                            },
                            child: Container(
                              width: 60,
                              height: 40,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 192, 192, 192)),
                                  color:
                                      const Color.fromARGB(255, 96, 187, 178),
                                  borderRadius: BorderRadius.circular(5)),
                              child: const Center(
                                  child: Text(
                                "Teal",
                                style: TextStyle(color: Colors.white),
                              )),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: GestureDetector(
                            onTap: () {
                              themeController.getGreyThemeData();
                              themeController.update();
                            },
                            child: Container(
                              width: 60,
                              height: 40,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 192, 192, 192)),
                                  color:
                                      const Color.fromARGB(255, 175, 175, 175),
                                  borderRadius: BorderRadius.circular(5)),
                              child: const Center(
                                  child: Text(
                                "Grey",
                                style: TextStyle(color: Colors.white),
                              )),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: GestureDetector(
                            onTap: () {
                              themeController.getLightBlueThemeData();
                              themeController.update();
                            },
                            child: Container(
                              width: 60,
                              height: 40,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 192, 192, 192)),
                                  color:
                                      const Color.fromARGB(255, 198, 222, 238),
                                  borderRadius: BorderRadius.circular(5)),
                              child: const Center(child: Text("Blue")),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: GestureDetector(
                            onTap: () {
                              themeController.getDarkBlueThemeData();
                              themeController.update();
                            },
                            child: Container(
                              width: 60,
                              height: 40,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 192, 192, 192)),
                                  color: HexColor("#142136"),
                                  borderRadius: BorderRadius.circular(5)),
                              child: const Center(
                                  child: Text(
                                "Blue-2",
                                style: TextStyle(color: Colors.white),
                              )),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: GestureDetector(
                            onTap: () {
                              themeController.getDarkThemeData();
                              themeController.update();
                            },
                            child: Container(
                              width: 60,
                              height: 40,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 192, 192, 192)),
                                  color: const Color.fromARGB(255, 77, 77, 77),
                                  borderRadius: BorderRadius.circular(5)),
                              child: const Center(
                                  child: Text(
                                "Dark",
                                style: TextStyle(color: Colors.white),
                              )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
