import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:holy_bible_app/src/pages/home/logic.dart';
import 'package:holy_bible_app/src/utils/appcolor.dart';
import 'package:sizer/sizer.dart';

import '../../utils/api_state_handler.dart';
import '../../widget/custom_progress_indicator.dart';
import '../../widget/refresh_error_widget.dart';

class AboutView extends StatelessWidget {
  AboutView({Key? key}) : super(key: key);
  final HomePageController homeController = Get.find<HomePageController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle:  SystemUiOverlayStyle(
            statusBarColor: AppColors.primaryColor,
            statusBarIconBrightness: Brightness.light),
        elevation: 0,
        backgroundColor:  AppColors.primaryColor,
        title: Text(
          'about'.tr,
          style: const TextStyle(color: Colors.white),
        ),
        // automaticallyImplyLeading: false,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back, color: AppColors.white),
        //   onPressed: () {
        //     Get.back();
        //   },
        // ),
        iconTheme: const IconThemeData(color: AppColors.white),
      ),
      body: SafeArea(
        child: GetBuilder<HomePageController>(
          init: HomePageController(),
          initState: (_) {},
          builder: (_) {
            if (homeController.apiStateHandler.apiState == ApiState.loading) {
              return const Center(
                child: CustomProgressIndicator(),
              );
            } else if (homeController.apiStateHandler.apiState ==
                ApiState.success) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(5,0,5,0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: SizedBox(
                          height: 90.h,
                          child: Card(
                            elevation: 0,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  10.0, 0.0, 10.0, 0),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 5,),
                                    Center(
                                      child: Text(
                                        homeController
                                            .apiStateHandler.data!.aboutApp,
                                        textAlign: TextAlign.justify,
                                        style: const TextStyle(
                                            color: AppColors.black,
                                            fontSize: 16),
                                      ),
                                    ),
                                    const SizedBox(height: 25,)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      
                    ],
                  ),
                ),
              );
            } else if (homeController.apiStateHandler.apiState ==
                ApiState.error) {
              return RefreshErrorWidget(
                showBackToHomeButton: true,
                assetImage: "assets/images/error.png",
                errorMessage: homeController.apiStateHandler.error!,
                onRefresh: () async {
                  homeController.fetchConfigsData();
                  homeController.update();
                },
              );
            } else {
              return RefreshErrorWidget(
                showBackToHomeButton: true,
                assetImage: "assets/images/error.png",
                errorMessage:
                    "No internet connection, please check your internet connection and try again.",
                onRefresh: () async {
                  homeController.fetchConfigsData();
                  homeController.update();
                },
              );
            }
          },
        ),
      ),
    );
  }
}
