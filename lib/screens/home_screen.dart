import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to calculate screen width to avoid null issues
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
          'Health Overview',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF56ab2f),
        elevation: 0,
      ),

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFa8e063), Color(0xFF56ab2f)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Device Connection Section
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
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
                    Row(
                      children: [
                        Icon(
                          Icons.watch, // Icon representing the device
                          size: 48,
                          color: Color(0xFF56ab2f),
                        ),
                        SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'RW-32', // Replace with dynamic device name if available
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Disconnected', // Replace with dynamic connection status
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
                        // Add functionality to reconnect the device
                        Get.snackbar(
                          'Reconnecting',
                          'Attempting to reconnect to RW-32...',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.green,
                          colorText: Colors.white,
                        );
                      },
                      icon: Icon(Icons.refresh, color: Color(0xFF56ab2f)),
                      label: Text(
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
              ),

              SizedBox(height: 20),

              // Greeting Header
              Text(
                'Welcome Back, John!', // Replace with dynamic user data if available
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Here is your health summary:',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              SizedBox(height: 20),

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
                    width: (screenWidth - 48) / 2,
                  ),
                  _buildHealthCard(
                    title: 'Heart Rate',
                    value: '72 bpm',
                    icon: Icons.favorite,
                    color: Colors.redAccent,
                    width: (screenWidth - 48) / 2,
                  ),
                  _buildHealthCard(
                    title: 'Calories',
                    value: '2,350 kcal',
                    icon: Icons.local_fire_department,
                    color: Colors.orangeAccent,
                    width: (screenWidth - 48) / 2,
                  ),
                  _buildHealthCard(
                    title: 'Sleep',
                    value: '6 hrs 45 min',
                    icon: Icons.bedtime,
                    color: Colors.purpleAccent,
                    width: (screenWidth - 48) / 2,
                  ),
                  _buildHealthCard(
                    title: 'Blood Pressure',
                    value: '120/80 mmHg',
                    icon: Icons.health_and_safety,
                    color: Colors.teal,
                    width: (screenWidth - 48) / 2,
                  ),
                ],
              ),

              SizedBox(height: 20),

              // Weekly Progress Chart Placeholder
              Text(
                'Weekly Activity',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    'Chart Placeholder',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // Floating Action Button for Notifications
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
        backgroundColor: Color(0xFF56ab2f),
        child: Icon(Icons.notifications, color: Colors.white),
      ),

      // Bottom Navigation Bar
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
  }

  // Helper method to build health data cards
  Widget _buildHealthCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required double width, // Add width as a parameter
  }) {
    return Container(
      width: width,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 36),
          SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
