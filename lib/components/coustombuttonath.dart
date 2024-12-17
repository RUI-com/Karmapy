// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../Theme/color.dart';

class CoustomButtonAuth extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  const CoustomButtonAuth({super.key, required this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 40,
      padding: EdgeInsets.all(15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      color: primaryColor,
      textColor: Colors.white,
      onPressed: onPressed,
      child: Text(title),
    );
  }
}
