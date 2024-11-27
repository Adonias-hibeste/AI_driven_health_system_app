import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFa8e063), Color(0xFF56ab2f)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // App Logo or Icon
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person_add_alt,
                        size: 50,
                        color: Color(0xFF56ab2f),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                // Title
                Center(
                  child: Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),

                SizedBox(height: 40),

                // Full Name Field
                _buildTextField(
                  hintText: 'Full Name',
                  icon: Icons.person,
                ),

                SizedBox(height: 15),

                // Email Field
                _buildTextField(
                  hintText: 'Email',
                  icon: Icons.email,
                ),

                SizedBox(height: 15),

                // Phone Number Field
                _buildTextField(
                  hintText: 'Phone Number',
                  icon: Icons.phone,
                ),

                SizedBox(height: 15),

                // Address Field
                _buildTextField(
                  hintText: 'Address',
                  icon: Icons.location_on,
                ),

                SizedBox(height: 15),

                // Gender Dropdown
                _buildDropdownField(
                  hintText: 'Gender',
                  icon: Icons.wc,
                ),

                SizedBox(height: 15),

                // Password Field
                _buildTextField(
                  hintText: 'Password',
                  icon: Icons.lock,
                  isPassword: true,
                ),

                SizedBox(height: 30),

                // Sign Up Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed('/home');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 5,
                    ),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Color(0xFF56ab2f),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                // Already have an account link
                Center(
                  child: TextButton(
                    onPressed: () {
                      Get.toNamed('/login');
                    },
                    child: Text(
                      "Already have an account? Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper Method for TextField
  Widget _buildTextField({
    required String hintText,
    required IconData icon,
    bool isPassword = false,
  }) {
    return TextField(
      obscureText: isPassword,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(icon, color: Color(0xFF56ab2f)),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      ),
    );
  }

  // Helper Method for Dropdown Field
  Widget _buildDropdownField({
    required String hintText,
    required IconData icon,
  }) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(icon, color: Color(0xFF56ab2f)),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      ),
      items: ['Male', 'Female']
          .map((gender) => DropdownMenuItem<String>(
                value: gender,
                child: Text(gender),
              ))
          .toList(),
      onChanged: (value) {
        // Handle selection
      },
    );
  }
}
