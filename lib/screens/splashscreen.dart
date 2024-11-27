import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:predictive_health_management_system/screens/login_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Navigate to the LoginScreen after 4 seconds
    Future.delayed(Duration(seconds: 4), () {
      Get.off(() => LoginScreen()); // Navigate to the LoginScreen
    });

    return Scaffold(
      body: Container(
        color: Colors.white, // Set background color to white
        child: Center(
          child: Lottie.asset(
            'assets/animations/Animation - 1732690848522.json', // Replace with your animation file path
            width: 250, // Slightly larger animation size
            height: 250,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
