// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

import 'Theme/color.dart';

class CategoriesBar extends StatefulWidget {
  final Function(String) onCategorySelected; // تمرير التصنيف عند التغيير

  CategoriesBar({required this.onCategorySelected});

  @override
  _CategoriesBarState createState() => _CategoriesBarState();
}

class _CategoriesBarState extends State<CategoriesBar> {
  final List<Map<String, String>> categories = [
    {'name': 'ازياء', 'key': 'ازياء'},
    {'name': 'موبايلات وتابلت', 'key': 'موبايلات وتابلت'},
    {'name': 'الصحة والجمال', 'key': 'الصحة والجمال'},
    {'name': 'المنزل والأثاث', 'key': 'المنزل والأثاث'},
    {'name': 'أجهزة منزلية', 'key': 'أجهزة منزلية'},
    {'name': 'التلفزيونات والصوتيات', 'key': 'التلفزيونات والصوتيات'},
    {'name': 'منتجات العناية بالأطفال', 'key': 'منتجات العناية بالأطفال'},
    {'name': 'بقالة', 'key': 'بقالة'},
    {'name': 'الكمبيوتر', 'key': 'الكمبيوتر'},
    {'name': 'مستلزمات رياضية', 'key': 'مستلزمات رياضية'},
    {'name': 'ألعاب', 'key': 'ألعاب'},
    {'name': 'أقسام أخرى', 'key': 'أقسام أخرى'},
  ];

  int selectedIndex = 0; // التصنيف المختار

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(categories.length, (index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index; // تحديث التصنيف المختار
              });
              widget.onCategorySelected(
                  category['key']!); // استدعاء الحدث عند تغيير التصنيف
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              margin: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: selectedIndex == index ? primaryColor : Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                category['name']!,
                style: TextStyle(
                  color: selectedIndex == index ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
