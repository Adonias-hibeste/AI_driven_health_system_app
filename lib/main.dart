import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:predictive_health_management_system/screens/home_screen.dart';
import 'package:predictive_health_management_system/screens/login_screen.dart';
import 'package:predictive_health_management_system/screens/medication_screen.dart';
import 'package:predictive_health_management_system/screens/profile_screen.dart';
import 'package:predictive_health_management_system/screens/settings_screen.dart';
import 'package:predictive_health_management_system/screens/signup_screen.dart';
import 'package:predictive_health_management_system/screens/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/signup',
      getPages: [
        GetPage(name: '/SplashScreen', page: () => SplashScreen()),
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/signup', page: () => SignupScreen()),
        GetPage(
            name: '/medication_reminder',
            page: () => MedicationReminderScreen()),
        GetPage(name: '/profile', page: () => ProfilePage()),
        GetPage(name: '/settings', page: () => SettingsPage()),
      ],
    );
  }
}
