import 'package:empapp/presentation/pages/onboard/onboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() => runApp(OnboardingApp());

class OnboardingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnboardingScreen(),
    );
  }
}




