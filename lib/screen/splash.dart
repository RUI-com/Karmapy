// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(Duration(milliseconds: 10000), () {});
    Get.offNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/logo/intro.png"),
                  fit: BoxFit.cover)),
        ),
        Center(
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/logo/logo.png"),
                    fit: BoxFit.fill)),
          ),
        )
      ],
    ));
  }
}
