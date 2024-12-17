// ignore_for_file: file_names

import 'package:flutter/material.dart';

class TextTitle extends StatelessWidget {
  final String title;
  final String fontStyle;
  final double size;
  final Color colortext;
  const TextTitle(
      {super.key,
      required this.title,
      required this.fontStyle,
      required this.size,
      required this.colortext});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontFamily: fontStyle, fontSize: size, color: colortext),
    );
  }
}
