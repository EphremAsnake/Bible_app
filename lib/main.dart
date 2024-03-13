import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:get/get.dart';
import 'package:holy_bible_app/src/pages/home/logic.dart';
import 'package:logger/logger.dart';
import 'package:sizer/sizer.dart';

import 'routes.dart';
import 'src/controller/configdatacontroller.dart';
import 'src/controller/datagetterandsetter.dart';
import 'src/pages/home/homepage.dart';
import 'src/pages/splash/splashscreen.dart';
import 'src/services/database_service.dart';
import 'src/services/http_client/http_service.dart';
import 'src/services/http_client/http_service_impl.dart';
import 'src/services/masterdatahelper.dart';
import 'src/utils/Strings.dart';
import 'src/utils/app_translation.dart';
import 'src/utils/appcolor.dart';
import 'src/utils/storagepreference.dart';
import 'src/widget/custom_easy_loading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initApp();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  AppColors.loadPrimaryColor();

  FlutterStatusbarcolor.setStatusBarColor(AppColors.primaryColor);
  FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
  Get.put(DataGetterAndSetter());
  Get.put<HttpService>(HttpServiceImpl());
  Get.put(HomePageController());

  Get.put(MasterDataController());

  //getting app's Config data
  await MasterDataHelper().getMasterData();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  // This widget is the root of your application.
  SharedPreferencesStorage sharedPreferencesStorage =
      SharedPreferencesStorage();

  final HomePageController homeController = Get.find<HomePageController>();
  late String selectedLocale;
  List<String> selectedLocales = [];
  Logger logger = Logger();
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    initValues();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        // logger.e("APP Resumed");
        homeController.fetchConfigsData();
        break;
      case AppLifecycleState.inactive:
        //logger.e("inactive");
        break;
      case AppLifecycleState.paused:
        //logger.e("inactive");
        break;
      case AppLifecycleState.detached:
        //logger.e("paused");
        break;
      case AppLifecycleState.hidden:
        //logger.e("hidden");
        break;
    }
  }

  Future<void> initValues() async {
    selectedLocale =
        await sharedPreferencesStorage.readStringData(Strings.selectedLocale) ??
            "";

    if (selectedLocale != "") {
      selectedLocales = selectedLocale.split("_");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        builder: EasyLoading.init(),
        translations: AppTranslation(),
        locale: selectedLocales.isNotEmpty
            ? Locale(selectedLocales[0], selectedLocales[1])
            : const Locale('ln', 'OL'),
        fallbackLocale: const Locale('en', 'US'),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: customSwatch,
        ),
        title: "Holy Bible",
        getPages: routes(),
        initialRoute: PageRoutes.splash,
        //home: SplashScreenPage(),
        // initialRoute: AppPages.INITIAL,
        // getPages: AppPages.routes,
      );
    });
  }
}

Future initApp() async {
  CustomEasyLoading.initEasyLoading();
  await DatabaseService().copyDatabaseBooks();
  await DatabaseService().copyDatabaseEng();
  await DatabaseService().copyDatabaseOtherLanguage();
  SharedPreferencesStorage sharedPreferencesStorage =
      SharedPreferencesStorage();
  String? bookName =
      await sharedPreferencesStorage.readStringData(Strings.selectedBookKey);

  Logger logger = Logger();
  logger.e(bookName);
}

MaterialColor customSwatch = MaterialColor(0xff7B5533, {
  50: AppColors.primaryColor.withOpacity(0.1),
  100: AppColors.primaryColor.withOpacity(0.2),
  200: AppColors.primaryColor.withOpacity(0.3),
  300: AppColors.primaryColor.withOpacity(0.4),
  400: AppColors.primaryColor.withOpacity(0.5),
  500: AppColors.primaryColor.withOpacity(0.6),
  600: AppColors.primaryColor.withOpacity(0.7),
  700: AppColors.primaryColor.withOpacity(0.8),
  800: AppColors.primaryColor.withOpacity(0.9),
  900: AppColors.primaryColor.withOpacity(1.0),
});
