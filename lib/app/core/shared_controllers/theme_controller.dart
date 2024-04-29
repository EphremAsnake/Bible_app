import 'package:american_bible/app/core/cache/shared_pereferance_storage.dart';
import 'package:american_bible/app/core/shared_controllers/master_data_controller.dart';
import 'package:american_bible/app/utils/helpers/app_colors.dart';
import 'package:american_bible/app/utils/helpers/hex_color_helper.dart';
import 'package:american_bible/app/utils/keys/keys.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  final MasterDataController controller = Get.find();
  Rx<ThemeDataModel?> themeData = Rx<ThemeDataModel?>(null);
  SharedPreferencesStorage sharedPreferencesStorage =
      SharedPreferencesStorage();

  void getCachedTheme(String selectedTheme) async {
    if (selectedTheme == "getLightThemeData") {
      getLightThemeData();
    } else if (selectedTheme == "getDarkThemeData") {
      getDarkThemeData();
    } else if (selectedTheme == "getAmberThemeData") {
      getAmberThemeData();
    } else if (selectedTheme == "getGoldThemeData") {
      getGoldThemeData();
    } else if (selectedTheme == "getLightBlueThemeData") {
      getLightBlueThemeData();
    } else if (selectedTheme == "getDarkBlueThemeData") {
      getDarkBlueThemeData();
    } else if (selectedTheme == "getGreyThemeData") {
      getGreyThemeData();
    } else if (selectedTheme == "getTealThemeData") {
      getTealThemeData();
    } else {
      getLightThemeData();
    }
  }

  void getLightThemeData() async {
    final theme = ThemeDataModel(
      whiteColor: HexColor("#ffffff"),
      backgroundColor: HexColor("#FEFEFE"),
      primaryColor: HexColor("#7B5533"),
      lightPrimary: HexColor('#997252'),
      blackColor: HexColor("#000000"),
      grayTextColor: HexColor(
        "#747475",
      ),
      shadowColor: HexColor("#EEEDED"),
      splashColor: HexColor("#AF703A"),
      errorColor: HexColor("#FF1100"),
      lightGrey: HexColor("#cccbc8"),
      numbersColor: HexColor("#FF922D26"),
      verseColor: HexColor("#000000"),
      cardColor: HexColor("#ffffff"),
      keyboardColor: HexColor("#ebebeb"),
    );
    themeData.value = theme;
    FlutterStatusbarcolor.setStatusBarColor(themeData.value!.primaryColor);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    await sharedPreferencesStorage.saveStringData(
        Keys.selectedTheme, "getLightThemeData");
  }

  void getDarkThemeData() async {
    final theme = ThemeDataModel(
      whiteColor: HexColor("#EEEEEE"),
      backgroundColor: HexColor("#252626"),
      primaryColor: HexColor("#876904"),
      lightPrimary: HexColor('#666565'),
      blackColor: HexColor("#000000"),
      grayTextColor: HexColor(
        "#626367",
      ),
      shadowColor: HexColor("#252626"),
      splashColor: HexColor("#AF703A"),
      errorColor: HexColor("#FF1100"),
      lightGrey: HexColor("#626367"),
      numbersColor: HexColor("#876904"),
      verseColor: HexColor("#EEEEEE"),
      cardColor: HexColor("#807e7e"),
      keyboardColor: HexColor("#807e7e"),
    );
    themeData.value = theme;
    FlutterStatusbarcolor.setStatusBarColor(themeData.value!.primaryColor);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    await sharedPreferencesStorage.saveStringData(
        Keys.selectedTheme, "getDarkThemeData");
  }

  void getAmberThemeData() async {
    final theme = ThemeDataModel(
      whiteColor: HexColor("#EEEEEE"),
      backgroundColor: HexColor("#f7f3e9"),
      primaryColor: HexColor("#9c3321"),
      lightPrimary: HexColor('#c75542'),
      blackColor: HexColor("#000000"),
      grayTextColor: HexColor(
        "#626367",
      ),
      shadowColor: HexColor("#f7f3e9"),
      splashColor: HexColor("#AF703A"),
      errorColor: HexColor("#FF1100"),
      lightGrey: HexColor("#626367"),
      numbersColor: HexColor("#9c3321"),
      verseColor: HexColor("#000000"),
      cardColor: HexColor("#ded2a6"),
      keyboardColor: HexColor("#ded2a6"),
    );
    themeData.value = theme;
    FlutterStatusbarcolor.setStatusBarColor(themeData.value!.primaryColor);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    await sharedPreferencesStorage.saveStringData(
        Keys.selectedTheme, "getAmberThemeData");
  }

  void getGoldThemeData() async {
    final theme = ThemeDataModel(
      whiteColor: HexColor("#EEEEEE"),
      backgroundColor: HexColor("#e3decc"),
      primaryColor: HexColor("#8B6C2F"),
      lightPrimary: HexColor('#ad8a44'),
      blackColor: HexColor("#000000"),
      grayTextColor: HexColor(
        "#626367",
      ),
      shadowColor: HexColor("#f5edd3"),
      splashColor: HexColor("#AF703A"),
      errorColor: HexColor("#FF1100"),
      lightGrey: HexColor("#626367"),
      numbersColor: HexColor("#8B6C2F"),
      verseColor: HexColor("#000000"),
      cardColor: HexColor("#e3cdaa"),
      keyboardColor: HexColor("#e3cdaa"),
    );
    themeData.value = theme;
    FlutterStatusbarcolor.setStatusBarColor(themeData.value!.primaryColor);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    await sharedPreferencesStorage.saveStringData(
        Keys.selectedTheme, "getGoldThemeData");
  }

  void getLightBlueThemeData() async {
    final theme = ThemeDataModel(
      whiteColor: HexColor("#EEEEEE"),
      backgroundColor: HexColor("#d1e5f0"),
      primaryColor: HexColor("#1d6d99"),
      lightPrimary: HexColor('#5891b0'),
      blackColor: HexColor("#000000"),
      grayTextColor: HexColor(
        "#626367",
      ),
      shadowColor: HexColor("#d4f0ff"),
      splashColor: HexColor("#AF703A"),
      errorColor: HexColor("#FF1100"),
      lightGrey: HexColor("#626367"),
      numbersColor: HexColor("#1d6d99"),
      verseColor: HexColor("#000000"),
      cardColor: HexColor("#add9f0"),
      keyboardColor: HexColor("#add9f0"),
    );
    themeData.value = theme;
    FlutterStatusbarcolor.setStatusBarColor(themeData.value!.primaryColor);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    await sharedPreferencesStorage.saveStringData(
        Keys.selectedTheme, "getLightBlueThemeData");
  }

  void getDarkBlueThemeData() async {
    final theme = ThemeDataModel(
      whiteColor: HexColor("#EEEEEE"),
      backgroundColor: HexColor("#425d8a"),
      primaryColor: HexColor("#819bc7"),
      lightPrimary: HexColor('#4d6796'),
      blackColor: HexColor("#000000"),
      grayTextColor: HexColor(
        "#626367",
      ),
      shadowColor: HexColor("#425d8a"),
      splashColor: HexColor("#AF703A"),
      errorColor: HexColor("#FF1100"),
      lightGrey: HexColor("#626367"),
      numbersColor: HexColor("#9bacc9"),
      verseColor: HexColor("#ffffff"),
      cardColor: HexColor("#5772a1"),
      keyboardColor: HexColor("#5772a1"),
    );
    themeData.value = theme;
    FlutterStatusbarcolor.setStatusBarColor(themeData.value!.primaryColor);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    await sharedPreferencesStorage.saveStringData(
        Keys.selectedTheme, "getDarkBlueThemeData");
  }

  void getGreyThemeData() async {
    final theme = ThemeDataModel(
      whiteColor: HexColor("#EEEEEE"),
      backgroundColor: HexColor("#dbd9d9"),
      primaryColor: HexColor("#575656"),
      lightPrimary: HexColor('#737272'),
      blackColor: HexColor("#000000"),
      grayTextColor: HexColor(
        "#626367",
      ),
      shadowColor: HexColor("#dbd9d9"),
      splashColor: HexColor("#AF703A"),
      errorColor: HexColor("#FF1100"),
      lightGrey: HexColor("#626367"),
      numbersColor: HexColor("#575656"),
      verseColor: HexColor("#000000"),
      cardColor: HexColor("#cccccc"),
      keyboardColor: HexColor("#cccccc"),
    );
    themeData.value = theme;
    FlutterStatusbarcolor.setStatusBarColor(themeData.value!.primaryColor);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    await sharedPreferencesStorage.saveStringData(
        Keys.selectedTheme, "getGreyThemeData");
  }

  void getTealThemeData() async {
    final theme = ThemeDataModel(
      whiteColor: HexColor("#EEEEEE"),
      backgroundColor: HexColor("#caf6fa"),
      primaryColor: HexColor("#006363"),
      lightPrimary: HexColor('#3a6d70'),
      blackColor: HexColor("#000000"),
      grayTextColor: HexColor(
        "#626367",
      ),
      shadowColor: HexColor("#caf6fa"),
      splashColor: HexColor("#AF703A"),
      errorColor: HexColor("#FF1100"),
      lightGrey: HexColor("#626367"),
      numbersColor: HexColor("#006363"),
      verseColor: HexColor("#000000"),
      cardColor: HexColor("#b4dee0"),
      keyboardColor: HexColor("#b4dee0"),
    );
    themeData.value = theme;
    FlutterStatusbarcolor.setStatusBarColor(themeData.value!.primaryColor);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    await sharedPreferencesStorage.saveStringData(
        Keys.selectedTheme, "getTealThemeData");
  }
}
