// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../Theme/color.dart';

class SearchTextfiled extends StatelessWidget {
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final void Function()? onPressed;
  const SearchTextfiled(
      {super.key, this.controller, this.onChanged, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return // إضافة TextField للبحث
        Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: onPressed,
                ),
                filled: true,
                fillColor: textfildColor,
                hintText: 'ابحث عن المنتج...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(style: BorderStyle.none),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(style: BorderStyle.none),
                ),
              ),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
