import 'package:spanish_bible/app/core/shared_controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

final themeData = Get.find<ThemeController>().themeData.value;
Future<void> showExitConfirmationDialog(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Exit App?'),
        content: const Text('Are you sure you want to exit the app?'),
        actionsPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'CANCEL',
              style: TextStyle(fontSize: 12.sp, color: themeData?.primaryColor),
            ),
          ),
          TextButton(
            onPressed: () {
              SystemNavigator.pop();
            },
            child: Text(
              'EXIT',
              style: TextStyle(fontSize: 12.sp, color: themeData?.errorColor),
            ),
          ),
        ],
      );
    },
  );
}
