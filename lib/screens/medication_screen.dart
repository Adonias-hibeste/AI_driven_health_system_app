import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:predictive_health_management_system/models/medication.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzData;

class MedicationReminderScreen extends StatefulWidget {
  @override
  _MedicationReminderScreenState createState() =>
      _MedicationReminderScreenState();
}

class _MedicationReminderScreenState extends State<MedicationReminderScreen> {
  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  late List<MedicationReminder> _medicationList;
  int _currentIndex = 1; // Track the selected bottom navigation bar index

  @override
  void initState() {
    super.initState();
    tzData.initializeTimeZones(); // Initialize the timezone database
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _initializeNotifications();
    _medicationList = [
      MedicationReminder(
        medicineName: "Metformin",
        dosage: "500 mg",
        time: DateTime(2024, 11, 26, 8, 0), // 8:00 AM
      ),
      MedicationReminder(
        medicineName: "Amlodipine",
        dosage: "5 mg",
        time: DateTime(2024, 11, 26, 14, 0), // 2:00 PM
      ),
      MedicationReminder(
        medicineName: "Lisinopril",
        dosage: "10 mg",
        time: DateTime(2024, 11, 26, 20, 0), // 8:00 PM
      ),
    ];
  }

  void _initializeNotifications() {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _scheduleNotification(MedicationReminder medication) async {
    var androidDetails = AndroidNotificationDetails(
      'medication_channel',
      'Medication Reminders',
      channelDescription: 'Channel for medication reminders',
      importance: Importance.high,
      priority: Priority.high,
    );
    var notificationDetails = NotificationDetails(android: androidDetails);

    // Use ZonedSchedule for time-based scheduling
    final tz.TZDateTime scheduledDate = tz.TZDateTime.from(
        DateTime(
          medication.time.year,
          medication.time.month,
          medication.time.day,
          medication.time.hour,
          medication.time.minute,
          medication.time.second,
        ),
        tz.local); // Schedule at the local timezone

    // await _flutterLocalNotificationsPlugin.zonedSchedule(
    //   0,
    //   'Medication Reminder',
    //   'It\'s time to take ${medication.medicineName} (${medication.dosage})',
    //   scheduledDate,
    //   notificationDetails,
    //   androidAllowWhileIdle: true,
    //   uiLocalNotificationDateInterpretation:
    //       UILocalNotificationDateInterpretation.absoluteTime,
    //   matchDateTimeComponents: DateTimeComponents.time,
    // );
  }

  void _onNavBarItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    // Add navigation logic here if necessary (e.g., navigating to another screen)
    switch (index) {
      case 0:
        Get.toNamed('/home');
        break;
      case 1:
        Get.toNamed('/medication_reminder');
        break;
      case 2:
        Get.toNamed('/profile');
        break;
      case 3:
        Get.toNamed('/settings');
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back, // Back arrow icon
            color: Colors.white, // Set icon color to white
          ),
          onPressed: () {
            // Navigate back to the previous page
            Get.back(); // Use GetX to go back
          },
        ),
        title: Text(
          'Medication Reminder',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF56ab2f),
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFa8e063), Color(0xFF56ab2f)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Medication Reminders Header
                      Text(
                        'Your Medication Schedule',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20),

                      // Display medications classified by time of day
                      _buildMedicationTimeSection(
                          "Morning (8:00 AM)", _medicationList),
                      _buildMedicationTimeSection(
                          "Afternoon (2:00 PM)", _medicationList),
                      _buildMedicationTimeSection(
                          "Evening (8:00 PM)", _medicationList),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xFF56ab2f),
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Overview',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.alarm),
            label: 'Reminders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _currentIndex,
        onTap: _onNavBarItemTapped,
      ),
    );
  }

  // Method to display medication list by time of day
  Widget _buildMedicationTimeSection(
      String timeOfDay, List<MedicationReminder> medications) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          timeOfDay,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 10),
        Column(
          children: medications
              .where(
                  (medication) => _getTimePeriod(medication.time) == timeOfDay)
              .map((medication) => _buildMedicationCard(medication))
              .toList(),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  // Method to determine if the medication belongs to the morning, afternoon, or evening
  String _getTimePeriod(DateTime time) {
    if (time.hour >= 6 && time.hour < 12) {
      return "Morning (8:00 AM)";
    } else if (time.hour >= 12 && time.hour < 18) {
      return "Afternoon (2:00 PM)";
    } else {
      return "Evening (8:00 PM)";
    }
  }

  // Method to build the card for each medication
  Widget _buildMedicationCard(MedicationReminder medication) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                medication.medicineName,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Dosage: ${medication.dosage}',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () => _scheduleNotification(medication),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF56ab2f),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            child: Text(
              'Remind Me',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
