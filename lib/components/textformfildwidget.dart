// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Theme/color.dart';

class Textformfildwidget extends StatefulWidget {
  final String lable;
  final TextEditingController mycontroler;
  final String hinttext;
  final String? Function(String?)? validator;
  final bool isPassword;

  const Textformfildwidget({
    super.key,
    required this.lable,
    required this.hinttext,
    required this.mycontroler,
    required this.validator,
    this.isPassword = false,
  });

  @override
  State<Textformfildwidget> createState() => _TextformfildwidgetState();
}

class _TextformfildwidgetState extends State<Textformfildwidget> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.lable,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(
          height: 10,
        ),
        TextFormField(
          validator: widget.validator,
          controller: widget.mycontroler,
          obscureText: widget.isPassword ? _obscureText : false,
          decoration: InputDecoration(
            hintText: widget.hinttext,
            hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
            contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
            filled: true,
            fillColor: textfildColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(style: BorderStyle.none),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(style: BorderStyle.none),
            ),
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : null,
          ),
        ),
        Container(
          height: 10,
        ),
      ],
    );
  }
}
