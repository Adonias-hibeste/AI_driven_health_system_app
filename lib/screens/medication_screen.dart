import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:predictive_health_management_system/screens/settings_screen.dart';

class MedicationReminderScreen extends StatefulWidget {
  @override
  _MedicationReminderScreenState createState() =>
      _MedicationReminderScreenState();
}

class _MedicationReminderScreenState extends State<MedicationReminderScreen> {
  late List<Map<String, dynamic>> medicationList;

  @override
  void initState() {
    super.initState();
    medicationList = [
      {"type": "Metformin", "time": "08:00 AM", "taken": false},
      {"type": "Amlodipine", "time": "02:00 PM", "taken": false},
      {"type": "Lisinopril", "time": "09:00 PM", "taken": false},
      {"type": "Glipizide", "time": "07:30 AM", "taken": false},
      {"type": "Atenolol", "time": "12:00 PM", "taken": false},
      {"type": "Losartan", "time": "08:00 PM", "taken": false},
    ];
  }

  String _categorizeTime(String time) {
    final parsedTime = TimeOfDay(
      hour: int.parse(time.split(":")[0]),
      minute: int.parse(time.split(":")[1].split(" ")[0]),
    );
    if (parsedTime.hour >= 6 && parsedTime.hour < 12) return "Morning";
    if (parsedTime.hour >= 12 && parsedTime.hour < 18) return "Afternoon";
    return "Evening";
  }

  void _markAsTaken(Map<String, dynamic> medication) {
    setState(() {
      medication['taken'] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    return Obx(() {
      bool isDarkMode = themeController.isDarkMode.value;

      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            onPressed: () => Get.back(),
          ),
          title: Text(
            'Medication Reminder',
            style: TextStyle(
              color: isDarkMode ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: isDarkMode ? Colors.black : Color(0xFF56ab2f),
          elevation: 0,
        ),
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              gradient: isDarkMode
                  ? null
                  : LinearGradient(
                      colors: [Color(0xFFa8e063), Color(0xFF56ab2f)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
              color: isDarkMode ? Colors.black : null,
            ),
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                _buildMedicationSection("Morning", isDarkMode),
                _buildMedicationSection("Afternoon", isDarkMode),
                _buildMedicationSection("Evening", isDarkMode),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
          selectedItemColor: const Color(0xFF56ab2f),
          unselectedItemColor: isDarkMode ? Colors.white70 : Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Overview'),
            BottomNavigationBarItem(
                icon: Icon(Icons.alarm), label: 'Reminders'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Settings'),
          ],
          currentIndex: 1,
          onTap: (index) {
            switch (index) {
              case 0:
                Get.toNamed('/home');
                break;
              case 1:
                break;
              case 2:
                Get.toNamed('/profile');
                break;
              case 3:
                Get.toNamed('/settings');
                break;
            }
          },
        ),
      );
    });
  }

  Widget _buildMedicationSection(String timeCategory, bool isDarkMode) {
    final categorizedMeds = medicationList
        .where((med) => _categorizeTime(med['time']) == timeCategory)
        .toList();
    if (categorizedMeds.isEmpty) return SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          timeCategory,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        SizedBox(height: 10),
        Column(
          children: categorizedMeds
              .map((med) => _buildMedicationCard(med, isDarkMode))
              .toList(),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildMedicationCard(
      Map<String, dynamic> medication, bool isDarkMode) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: isDarkMode
            ? []
            : [
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
                medication['type'],
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Time: ${medication['time']}',
                style: TextStyle(
                  fontSize: 14,
                  color: isDarkMode ? Colors.white70 : Colors.grey,
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed:
                medication['taken'] ? null : () => _markAsTaken(medication),
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  medication['taken'] ? Colors.grey : Color(0xFF56ab2f),
            ),
            child: Text(
              medication['taken'] ? 'Taken' : 'Mark as Taken',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
