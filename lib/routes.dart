import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:holy_bible_app/src/pages/settings/settings.dart';

import 'src/pages/about/aboutpage.dart';
import 'src/pages/home/homepage.dart';
import 'src/pages/splash/splashscreen.dart';

routes() => [
      GetPage(name: "/homepage", page: () => const HomePage()),
      GetPage(name: "/splash", page: () => SplashScreenPage()),
      GetPage(name: "/aboutPage", page: () => AboutView()),
      GetPage(name: "/settingsPage", page: () => SettingsView()),
    ];

class PageRoutes {
  static const String homepage = '/homepage';
  static const String splash = '/splash';
  static const String aboutPage = '/aboutPage';
  static const String settingsPage = '/settingsPage';

  Map<String, WidgetBuilder> routes() {
    return {
      homepage: (context) => const HomePage(),
      splash: (context) => SplashScreenPage(),
      aboutPage: (context) => AboutView(),
      settingsPage: (context) => SettingsView(),
    };
  }
}
