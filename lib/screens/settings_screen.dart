import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;
  bool _shareDataEnabled = false;
  bool _darkModeEnabled = false;
  int _currentIndex = 3;

  // Method to handle bottom navigation item taps
  void _onNavBarItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          'Settings',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF56ab2f),
        elevation: 2,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFa8e063), Color(0xFF56ab2f)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: ListView(
            children: [
              // Notifications Section
              _buildSectionHeader('Notifications'),
              _buildCard(
                child: _buildSwitchTile(
                  'Enable Medication Reminders',
                  _notificationsEnabled,
                  (value) {
                    setState(() {
                      _notificationsEnabled = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 20),

              // Account Management Section
              _buildSectionHeader('Account'),
              _buildCard(
                child: Column(
                  children: [
                    _buildListTile(
                      'Update Profile Information',
                      Icons.person,
                      () {
                        Get.toNamed('/profile');
                      },
                    ),
                    _buildDivider(),
                    _buildListTile(
                      'Change Email',
                      Icons.email,
                      () {
                        // Add change email functionality
                      },
                    ),
                    _buildDivider(),
                    _buildListTile(
                      'Change Password',
                      Icons.lock,
                      () {
                        // Add change password functionality
                      },
                    ),
                    _buildDivider(),
                    _buildListTile(
                      'Log Out',
                      Icons.exit_to_app,
                      () {
                        // Add log out functionality
                        Get.snackbar(
                          'Log Out',
                          'You have been logged out successfully!',
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                      },
                      textColor: Colors.red,
                    ),
                    _buildDivider(),
                    _buildListTile(
                      'Delete Account',
                      Icons.delete_forever,
                      () {
                        // Add delete account functionality
                        _confirmDeleteAccount(context);
                      },
                      textColor: Colors.red,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Privacy Settings Section
              _buildSectionHeader('Privacy'),
              _buildCard(
                child: _buildSwitchTile(
                  'Share Health Data with Providers',
                  _shareDataEnabled,
                  (value) {
                    setState(() {
                      _shareDataEnabled = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 20),

              // Theme Settings Section
              _buildSectionHeader('Appearance'),
              _buildCard(
                child: _buildSwitchTile(
                  'Enable Dark Mode',
                  _darkModeEnabled,
                  (value) {
                    setState(() {
                      _darkModeEnabled = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 20),

              // App Info Section
              _buildSectionHeader('App Information'),
              _buildCard(
                child: Column(
                  children: [
                    _buildListTile(
                      'About App',
                      Icons.info,
                      () {
                        Get.toNamed('/about');
                      },
                    ),
                    _buildDivider(),
                    _buildListTile(
                      'Terms and Conditions',
                      Icons.description,
                      () {
                        Get.toNamed('/terms');
                      },
                    ),
                  ],
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

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 5,
      shadowColor: Colors.black.withOpacity(0.1),
      color: Colors.white.withOpacity(0.9),
      child: child,
    );
  }

  Widget _buildListTile(String title, IconData icon, Function() onTap,
      {Color? textColor}) {
    return ListTile(
      leading: Icon(icon, color: Color(0xFF56ab2f)),
      title: Text(
        title,
        style: TextStyle(
          color: textColor ?? Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.grey[300],
      height: 1,
      thickness: 1,
      indent: 16,
      endIndent: 16,
    );
  }

  Widget _buildSwitchTile(String title, bool value, Function(bool) onChanged) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: Color(0xFF56ab2f),
        inactiveThumbColor: Colors.grey,
        inactiveTrackColor: Colors.grey[400],
      ),
    );
  }

  void _confirmDeleteAccount(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Account'),
          content: Text(
              'Are you sure you want to delete your account? This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                Get.snackbar(
                  'Account Deleted',
                  'Your account has been deleted successfully.',
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
                // Add delete account logic here
              },
              child: Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
