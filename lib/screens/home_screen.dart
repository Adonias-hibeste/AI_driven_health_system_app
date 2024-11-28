import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:predictive_health_management_system/screens/settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to calculate screen width to avoid null issues
    double screenWidth = MediaQuery.of(context).size.width;

    // Access the ThemeController
    final ThemeController themeController = Get.find<ThemeController>();

    return Obx(() {
      // Determine if dark mode is active
      bool isDarkMode = themeController.isDarkMode.value;

      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back, // Back arrow icon
              color: isDarkMode ? Colors.white : Colors.black, // Dynamic color
            ),
            onPressed: () {
              // Navigate back to the previous page
              Get.back(); // Use GetX to go back
            },
          ),
          title: Text(
            'Health Overview',
            style: TextStyle(
              color: isDarkMode ? Colors.white : Colors.black, // Dynamic color
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor:
              isDarkMode ? Colors.black : const Color(0xFF56ab2f), // Dynamic BG
          elevation: 0,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: isDarkMode
                ? null
                : const LinearGradient(
                    colors: [Color(0xFFa8e063), Color(0xFF56ab2f)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
            color: isDarkMode ? Colors.black : null, // Fallback for dark mode
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Device Connection Section
                _buildDeviceConnectionSection(isDarkMode),
                const SizedBox(height: 20),

                // Greeting Header
                Text(
                  'Welcome Back, John!', // Replace with dynamic user data if available
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Here is your health summary:',
                  style: TextStyle(
                    fontSize: 16,
                    color: isDarkMode ? Colors.white70 : Colors.black87,
                  ),
                ),
                const SizedBox(height: 20),

                // Health Data Cards
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    _buildHealthCard(
                      title: 'Steps',
                      value: '7,854',
                      icon: Icons.directions_walk,
                      color: Colors.blueAccent,
                      isDarkMode: isDarkMode,
                      width: (screenWidth - 48) / 2,
                    ),
                    _buildHealthCard(
                      title: 'Heart Rate',
                      value: '72 bpm',
                      icon: Icons.favorite,
                      color: Colors.redAccent,
                      isDarkMode: isDarkMode,
                      width: (screenWidth - 48) / 2,
                    ),
                    _buildHealthCard(
                      title: 'Calories',
                      value: '2,350 kcal',
                      icon: Icons.local_fire_department,
                      color: Colors.orangeAccent,
                      isDarkMode: isDarkMode,
                      width: (screenWidth - 48) / 2,
                    ),
                    _buildHealthCard(
                      title: 'Sleep',
                      value: '6 hrs 45 min',
                      icon: Icons.bedtime,
                      color: Colors.purpleAccent,
                      isDarkMode: isDarkMode,
                      width: (screenWidth - 48) / 2,
                    ),
                    _buildHealthCard(
                      title: 'Blood Pressure',
                      value: '120/80 mmHg',
                      icon: Icons.health_and_safety,
                      color: Colors.teal,
                      isDarkMode: isDarkMode,
                      width: (screenWidth - 48) / 2,
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Weekly Progress Chart Placeholder
                Text(
                  'Weekly Activity',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: isDarkMode ? Colors.grey[800] : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      'Chart Placeholder',
                      style: TextStyle(
                        color: isDarkMode ? Colors.white70 : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.snackbar(
              'No Notifications',
              'You currently have no new notifications.',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green,
              colorText: Colors.white,
            );
          },
          backgroundColor: const Color(0xFF56ab2f),
          child: const Icon(Icons.notifications, color: Colors.white),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
          selectedItemColor: const Color(0xFF56ab2f),
          unselectedItemColor: isDarkMode ? Colors.white70 : Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          items: const [
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
          onTap: (index) {
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
          },
        ),
      );
    });
  }

  // Helper method for device connection section
  Widget _buildDeviceConnectionSection(bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: isDarkMode
            ? []
            : [
                const BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(
                Icons.watch,
                size: 48,
                color: Color(0xFF56ab2f),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'RW-32',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Disconnected',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.redAccent,
                    ),
                  ),
                ],
              ),
            ],
          ),
          TextButton.icon(
            onPressed: () {
              Get.snackbar(
                'Reconnecting',
                'Attempting to reconnect to RW-32...',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.green,
                colorText: Colors.white,
              );
            },
            icon: const Icon(Icons.refresh, color: Color(0xFF56ab2f)),
            label: const Text(
              'Reconnect',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF56ab2f),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build health data cards
  Widget _buildHealthCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required double width,
    required bool isDarkMode,
  }) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: isDarkMode
            ? []
            : [
                const BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 32, color: color),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: isDarkMode ? Colors.white70 : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
