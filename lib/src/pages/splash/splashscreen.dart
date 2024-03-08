import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:holy_bible_app/src/pages/home/homepage.dart';
import 'package:holy_bible_app/src/pages/home/logic.dart';
import 'package:logger/logger.dart';
import 'package:sizer/sizer.dart';

import '../../controller/datagetterandsetter.dart';
import '../../controller/maincontroller.dart';
import '../../services/database_service.dart';
import '../../utils/Strings.dart';
import '../../utils/storagepreference.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _MySplashScreenPageState createState() => _MySplashScreenPageState();
}

class _MySplashScreenPageState extends State<SplashScreenPage> {
  Logger logger = Logger();
  @override
  void initState() {
    super.initState();
    //injecting home controller
    Get.lazyPut<MainController>(() => MainController(), fenix: true);
    //putting detail controller

    Get.lazyPut<HomePageController>(() => HomePageController(), fenix: true);
    //read books
    readsavedbookdata();
    // Future.delayed(const Duration(seconds: 1), () {
    //   if (mounted) {

    //   }
    // });
    //readBibleBooks();
  }

  void readBibleBooks() async {
    final MainController homeController = Get.find();
    await homeController.readBibleData();

    logger.e('Navigate to home');
    // navigate to home
    Get.to(const HomePage());
  }

  Future<void> readsavedbookdata() async {
    final DataGetterAndSetter getterAndSetterController =
        Get.find<DataGetterAndSetter>();
    final HomePageController controller = Get.find<HomePageController>();
    await EasyLoading.show(status: '...', indicator: const SizedBox());
    controller.isLoading = true;
    controller.update();
    SharedPreferencesStorage sharedPreferencesStorage =
        SharedPreferencesStorage();
    String? savedBibleName =
        await sharedPreferencesStorage.readStringData(Strings.selectedBookKey);
    getterAndSetterController.versesAMH = await DatabaseService()
        .changeBibleType(savedBibleName ?? Strings.bibletitle);
    getterAndSetterController.update();
    controller.allVerses.assignAll(getterAndSetterController.groupedBookList());

    //saving selected book to local storage
    sharedPreferencesStorage.saveStringData(
        Strings.selectedBookKey, savedBibleName ?? Strings.bibletitle);

    //set selected book Name
    controller.setSelectedBook(savedBibleName ?? Strings.bibletitle);
    controller.setInitialSelectedBookTypeOptions();

    // //scroll to top
    // controller.readerScrollController.animateTo(
    //   0.0, // Scroll to the top
    //   duration:
    //       const Duration(milliseconds: 500), // Adjust the duration as needed
    //   curve: Curves.easeInOut, // Use a different curve if desired
    // );

    EasyLoading.dismiss();
    controller.selectedRowIndex = -1;
    controller.isLoading = false;
    controller.update();
    readBibleBooks();
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
