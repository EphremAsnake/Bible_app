import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppColors {
  static Color primaryColor = Colors.brown;

  // static void updatePrimaryColor(Color newColor) {
  //   primaryColor = newColor;
  //   Get.changeTheme(ThemeData(primaryColor: newColor));
  // }
  static void updatePrimaryColor(Color newColor) async {
    primaryColor = newColor;
    Get.changeTheme(ThemeData(primaryColor: newColor));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('primaryColor', newColor.value);
  }

  static Future<void> loadPrimaryColor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? colorValue = prefs.getInt('primaryColor');
    if (colorValue != null) {
      primaryColor = Color(colorValue);
      Get.changeTheme(ThemeData(primaryColor: primaryColor));
    }
  }
  static const Color primarycolor2 = Color(0xFF01222B);
  static const Color secondarycolor = Color(0xFF022d36);
  static const Color thcolor = Color(0xFF997252);

  static const Color error = Colors.red;
  static const Color black = Colors.black;
  static const Color white = Colors.white;

   static List<Map<String, dynamic>> colorData = [
    {'name': 'Brown', 'color': Colors.brown},
    {'name': 'Red', 'color': Colors.red},
    {'name': 'Blue', 'color': Colors.blue},
    {'name': 'Green', 'color': Colors.green},
    {'name': 'Yellow', 'color': Colors.yellow},
    {'name': 'Orange', 'color': Colors.orange},
    {'name': 'Purple', 'color': Colors.purple},
    {'name': 'Cyan', 'color': Colors.cyan},
    {'name': 'Pink', 'color': Colors.pink},
    {'name': 'Teal', 'color': Colors.teal},
    {'name': 'Indigo', 'color': Colors.indigo},
  ];
}
