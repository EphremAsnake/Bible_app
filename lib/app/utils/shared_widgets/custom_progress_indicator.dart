import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({super.key});
  @override
  Widget build(BuildContext context) {
    return const SpinKitFadingCircle(
      size: 50,
      color: Color(0xff7B5533),
      duration: Duration(seconds: 1),
    );
  }
}
