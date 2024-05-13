import 'package:spanish_bible/app/core/cache/shared_pereferance_storage.dart';
import 'package:spanish_bible/app/core/core_dependency.dart';
import 'package:spanish_bible/app/core/shared_controllers/data_getter_and_setter_controller.dart';
import 'package:spanish_bible/app/core/shared_controllers/theme_controller.dart';
import 'package:spanish_bible/app/modules/detail/views/amharic_keyboard.dart';
import 'package:spanish_bible/app/utils/helpers/app_translation.dart';
import 'package:spanish_bible/app/utils/helpers/internetConnectivity.dart';
import 'package:spanish_bible/app/utils/helpers/master_data_helper.dart';
import 'package:spanish_bible/app/utils/keys/keys.dart';
import 'package:spanish_bible/app/utils/shared_widgets/custom_easy_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sizer/sizer.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final internetConnectivity = InternetConnectivity();
  await internetConnectivity.initialize();

  //initializing Hive
  await Hive.initFlutter();
  await Hive.openBox('bible_app');

  await initApp();

  //injecting http dependency
  CoreDependencyCreator.init();

  //getting app's master data
  await MasterDataHelper().getMasterData();

  //putting getter and setter controller
  Get.put(DataGetterAndSetter());

  SharedPreferencesStorage sharedPreferencesStorage =
      SharedPreferencesStorage();

  //setting app theme
  String selectedTheme =
      await sharedPreferencesStorage.readStringData(Keys.selectedTheme) ?? "";

  final themeController = Get.put(ThemeController());
  if (selectedTheme == "") {
    themeController.getLightThemeData();
  } else {
    themeController.getCachedTheme(selectedTheme);
  }

  String selectedLocale =
      await sharedPreferencesStorage.readStringData(Keys.selectedLocale) ?? "";
  List<String> selectedLocales = [];
  if (selectedLocale != "") {
    selectedLocales = selectedLocale.split("_");
  }

  // Set the app to be in portrait mode only
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  FlutterStatusbarcolor.setStatusBarColor(
      themeController.themeData.value!.primaryColor);
  FlutterStatusbarcolor.setStatusBarWhiteForeground(true);

  runApp(
    Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        builder: EasyLoading.init(),
        translations: AppTranslation(),
        locale: selectedLocales.isNotEmpty
            ? Locale(selectedLocales[0], selectedLocales[1])
            : const Locale('en', 'US'),
        fallbackLocale: const Locale('en', 'US'),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: customSwatch,
        ),
        title: "Burmese Bible",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
      );
    }),
  );
}

Future initApp() async {
  CustomEasyLoading.initEasyLoading();
}

MaterialColor customSwatch = MaterialColor(0xff7B5533, {
  50: const Color(0xff7B5533).withOpacity(0.1),
  100: const Color(0xff7B5533).withOpacity(0.2),
  200: const Color(0xff7B5533).withOpacity(0.3),
  300: const Color(0xff7B5533).withOpacity(0.4),
  400: const Color(0xff7B5533).withOpacity(0.5),
  500: const Color(0xff7B5533).withOpacity(0.6),
  600: const Color(0xff7B5533).withOpacity(0.7),
  700: const Color(0xff7B5533).withOpacity(0.8),
  800: const Color(0xff7B5533).withOpacity(0.9),
  900: const Color(0xff7B5533).withOpacity(1.0),
});
