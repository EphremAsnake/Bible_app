import 'package:american_bible/app/modules/detail/controllers/detail_controller.dart';
import 'package:american_bible/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _MySplashScreenPageState createState() => _MySplashScreenPageState();
}

class _MySplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    //injecting home controller
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    //putting detail controller
    Get.lazyPut<DetailController>(() => DetailController(), fenix: true);
    //read books
    readBibleBooks();
  }

  void readBibleBooks() async {
    final HomeController homeController = Get.find();
    await homeController.readBibleData();
    // navigate to home
    Get.toNamed("/detail");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/cross.png",
            height: 70.h,
            width: 60.w,
          ),
        ],
      ),
    );
  }
}
