import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:predictive_health_management_system/screens/home_screen.dart';
import 'package:predictive_health_management_system/screens/medication_screen.dart';
import 'package:predictive_health_management_system/screens/profile_screen.dart';
import 'package:predictive_health_management_system/screens/settings_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      getPages: [
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(
            name: '/medication_reminder',
            page: () => MedicationReminderScreen()),
        GetPage(name: '/profile', page: () => ProfilePage()),
        GetPage(name: '/settings', page: () => SettingsPage()),
      ],
    );
  }
}
