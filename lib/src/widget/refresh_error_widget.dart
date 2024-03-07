// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:holy_bible_app/src/pages/home/homepage.dart';
import 'package:holy_bible_app/src/utils/appcolor.dart';
import 'package:line_icons/line_icon.dart';
import 'package:sizer/sizer.dart';

class RefreshErrorWidget extends StatelessWidget {
  RefreshErrorWidget(
      {Key? key,
      required this.showBackToHomeButton,
      required this.onRefresh,
      required this.errorMessage,
      required this.assetImage})
      : super(key: key);

  Future<void> Function() onRefresh;
  String errorMessage;
  String assetImage;
  bool showBackToHomeButton;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RefreshIndicator(
        onRefresh: onRefresh,
        child: ListView(
          shrinkWrap: true,
          children: [
            const SizedBox(height: 30),
            Image.asset(
              assetImage,
              height: 120,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                errorMessage,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Colors.grey,
                    fontSize: SizerUtil.deviceType == DeviceType.mobile
                        ? 14.sp
                        : 16.sp,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Scroll to Refresh',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: AppColors.black.withOpacity(0.4),
                  fontSize:
                      SizerUtil.deviceType == DeviceType.mobile ? 13.sp : 16.sp,
                  fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
            Visibility(
              visible: showBackToHomeButton,
              child: const SizedBox(height: 25),
            ),
            Visibility(
              visible: showBackToHomeButton,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: GestureDetector(
                  onTap: () {
                    Get.offAll(
                      const HomePage(),
                      // Remove routes until reaching the /home route
                      predicate: (route) => route.settings.name == "/detail",
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      border: Border.all(
                        color: AppColors.primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              LineIcon.home(
                                size: 22.0,
                                color: AppColors.white,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Back To Home",
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 13.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
