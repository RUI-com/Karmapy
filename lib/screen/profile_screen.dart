// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Theme/color.dart';
import '../components/actionbutton.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = "";

  @override
  void initState() {
    super.initState();
    _getUserProfile();
  }

  // Function to get the user's profile information
  void _getUserProfile() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        userName = user.displayName ??
            "No name"; // If the name is null, show a default value
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF7F7F7), // Background color
        body: ListView(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Top Section
              Container(
                height: 220,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(
                        'https://wallpapers.com/images/hd/red-shirt-female-avatar-8palwx2265yqkm1p-2.jpg', // Replace with your image URL
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      userName,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '@$userName',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              // Button Section
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: () {
                    // Add your edit profile functionality here
                    Get.to(EditProfileScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: Text(
                    'Edit Profile',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              // Divider
              Divider(
                thickness: 1,
                color: Colors.grey[300],
                indent: 30,
                endIndent: 30,
              ),
              // Action Buttons Section
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    ActionButton(
                      icon: Icons.settings,
                      label: 'Settings',
                      onPressed: () {
                        // Add settings functionality
                      },
                    ),
                    ActionButton(
                      icon: Icons.language,
                      label: 'Change Language',
                      onPressed: () {
                        // Add change language functionality
                      },
                    ),
                    ActionButton(
                      icon: Icons.logout,
                      label: 'Log Out',
                      onPressed: () async {
                        GoogleSignIn googleSignIn = GoogleSignIn();
                        googleSignIn.disconnect();
                        await FirebaseAuth.instance.signOut();
                        Get.offAllNamed('/login');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ]));
  }
}
