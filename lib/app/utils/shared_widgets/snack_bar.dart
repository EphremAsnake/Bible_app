
import 'package:flutter/material.dart';
import 'package:get/get.dart';

SnackbarController customSnackBar(
    {required String title, required String body}) {
  return Get.snackbar(
    title,
    body,
    duration: const Duration(seconds: 2),
    backgroundColor: Colors.black,
    colorText: Colors.black,
    snackPosition: SnackPosition.BOTTOM,
    dismissDirection: DismissDirection.horizontal,
  );
}
