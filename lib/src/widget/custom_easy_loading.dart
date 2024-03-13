import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lottie/lottie.dart';

import '../utils/appcolor.dart';

class CustomEasyLoading {
  static final CustomEasyLoading _instance = CustomEasyLoading._internal();
  CustomEasyLoading._internal();
  static CustomEasyLoading getInstance() => _instance;
  static initEasyLoading() => _instance.init();
  init() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.circle
      ..maskType = EasyLoadingMaskType.custom
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 100.0
      ..indicatorWidget = Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.transparent,
        ),
        height: 80,
        width: 80,
        child: Lottie.asset(
          width: 100,
          height: 100,
          'assets/lotties/loading.json',
        ),
      )
      ..radius = 50.0
      ..progressColor =  AppColors.primaryColor
      ..backgroundColor = Colors.transparent
      ..indicatorColor =  AppColors.primaryColor
      ..textColor = Colors.white
      ..textStyle = const TextStyle(
        fontFamily: 'NoirPro',
        fontWeight: FontWeight.bold,
        fontSize: 10,
        color: Colors.white,
      )
      ..maskColor = Colors.black45
      ..userInteractions = false
      ..dismissOnTap = false
      ..boxShadow = <BoxShadow>[]
      ..customAnimation = CustomAnimation();
  }
}

class CustomAnimation extends EasyLoadingAnimation {
  CustomAnimation();

  @override
  Widget buildWidget(
    Widget child,
    AnimationController controller,
    AlignmentGeometry alignment,
  ) {
    double opacity = controller.value; //controller?.value ?? 0;
    return Opacity(
      opacity: opacity,
      child: RotationTransition(
        turns: controller,
        child: child,
      ),
    );
  }
}
