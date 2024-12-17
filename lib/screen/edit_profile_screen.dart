// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors, use_build_context_synchronously, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Theme/color.dart';
import '../components/textformfildwidget.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      try {
        User? user = _auth.currentUser;

        // Update display name
        if (_nameController.text.isNotEmpty) {
          await user?.updateDisplayName(_nameController.text);
        }

        // Update password
        if (_passwordController.text.isNotEmpty) {
          if (_passwordController.text == _confirmPasswordController.text) {
            await user?.updatePassword(_passwordController.text);
          } else {
            throw Exception("Passwords do not match!");
          }
        }

        // Refresh user to get updated details
        await user?.reload();
        user = _auth.currentUser;

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Profile updated successfully!")),
        );

        // Return to previous screen
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${e.toString()}")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      'https://wallpapers.com/images/hd/red-shirt-female-avatar-8palwx2265yqkm1p-2.jpg', // Replace with your image URL
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Textformfildwidget(
                  mycontroler: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  hinttext: "",
                  lable: "Name"),
              SizedBox(height: 5),
              Textformfildwidget(
                lable: "New Password",
                hinttext: "",
                mycontroler: _passwordController,
                validator: (value) {
                  if (value != null && value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
                isPassword: true,
              ),
              SizedBox(height: 5),
              Textformfildwidget(
                lable: "Confirm Password",
                hinttext: "",
                mycontroler: _confirmPasswordController,
                validator: (value) {
                  if (value != null && value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
                isPassword: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: Text(
                  'Save Changes',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
