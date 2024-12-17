// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Theme/color.dart';
import 'text-title.dart';

class SidebarMenu extends StatefulWidget {
  const SidebarMenu({super.key});

  @override
  State<SidebarMenu> createState() => _SidebarMenuState();
}

class _SidebarMenuState extends State<SidebarMenu> {
  String userName = "";
  String userEmail = "";

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
        userEmail = user.email ??
            "No email"; // If the email is null, show a default value
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      height: 500,
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      child: Container(
        child: Column(
          children: [
            //nav close
            Row(
              //red
              children: [
                Container(
                  width: 10,
                  height: 10,
                  margin: EdgeInsets.only(right: 5),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
                //yellow
                Container(
                  width: 10,
                  height: 10,
                  margin: EdgeInsets.only(right: 5),
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    shape: BoxShape.circle,
                  ),
                ),
                //green
                Container(
                  width: 10,
                  height: 10,
                  margin: EdgeInsets.only(right: 5),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            // profile data
            Container(
              decoration: BoxDecoration(
                color: textfildColor,
                borderRadius: BorderRadius.circular(5),
              ),
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //avatar profile (You can add user.photoURL here for an image if you want)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextTitle(
                        title: userName,
                        fontStyle: "PoppinsBold",
                        size: 15,
                        colortext: Colors.black,
                      ),
                      TextTitle(
                        title: userEmail,
                        fontStyle: "PoppinsRegular",
                        size: 10,
                        colortext: Colors.black,
                      ),
                    ],
                  ),

                  //more
                  IconButton(
                    onPressed: () async {
                      GoogleSignIn googleSignIn = GoogleSignIn();
                      googleSignIn.disconnect();
                      await FirebaseAuth.instance.signOut();
                      Get.offAllNamed('/login');
                    },
                    icon: Icon(Icons.exit_to_app),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 45,
            ),
          ],
        ),
      ),
    );
  }
}
