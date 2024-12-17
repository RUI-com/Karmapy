// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

void showErrorDialog(BuildContext context, String title, String message,
    IconData icon, Color coloricon) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: coloricon,
                size: 50,
              ),
              SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                message,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('OK'),
              ),
            ],
          ),
        ),
      );
    },
  );
}
