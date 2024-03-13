import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../utils/appcolor.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({super.key});
  @override
  Widget build(BuildContext context) {
    return  SpinKitFadingCircle(
      size: 50,
      color: AppColors.primaryColor,
      duration: const Duration(seconds: 1),
    );
  }
}
