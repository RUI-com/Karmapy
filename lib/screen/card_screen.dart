// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../Theme/color.dart';
import '../components/build-product-item.dart';

class CardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7), // لون الخلفية
      appBar: AppBar(
        title: Text(
          'Card',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFF7F7F7),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Debit Cards',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          SizedBox(height: 10),

          // البطاقة البنكية
          // البطاقة البنكية مع صورة
          Center(
            child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(16), // لتطبيق التدوير على الصورة
              child: Image.network(
                'https://www.visa.co.in/dam/VCOM/regional/ap/india/global-elements/images/in-visa-classic-card-498x280.png',
                width: 300,
                height: 170,
                fit: BoxFit.cover, // لجعل الصورة تغطي المساحة بشكل مناسب
              ),
            ),
          ),

          SizedBox(height: 30),

          // العنوان
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'FIND YOUR TRIP',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: primaryColor),
            ),
          ),

          SizedBox(height: 20),

          // المنتجات المشتراة
          Expanded(
            child: ListView(
              children: [
                buildProductItem('Minimal Chair', 'Lorem ipsum', '\$125.00'),
                buildProductItem('Classic Table', 'Lorem ipsum', '\$150.00'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
