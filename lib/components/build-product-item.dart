// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/material.dart';

import '../Theme/color.dart';

Widget buildProductItem(String title, String subtitle, String price) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 8,
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(price),
            SizedBox(width: 8),
            Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.arrow_forward_ios,
                    color: Colors.white, size: 16)),
          ],
        ),
      ),
    ),
  );
}
