// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, sort_child_properties_last, prefer_const_declarations, library_private_types_in_public_api, avoid_print
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'auth/login.dart';
import 'auth/phoneauthpage.dart';
import 'auth/signup.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'main_screen.dart';
import 'screen/splash.dart';
import 'screen/splash_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
  );

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    //  حالة الحساب يكل ثانية
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print(' ========================== User is currently signed out!');
      } else {
        print(' ========================== User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GetX App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: (FirebaseAuth.instance.currentUser != null &&
              FirebaseAuth.instance.currentUser!.emailVerified)
          ? SplashHome()
          : SplashScreen(),
      getPages: [
        GetPage(name: "/login", page: () => Login()),
        GetPage(name: "/signup", page: () => Singup()),
        GetPage(name: "/homepage", page: () => MainScreen()),
        GetPage(name: "/phonepage", page: () => PhoneAuthScreen()),
      ],
    );
  }
}
