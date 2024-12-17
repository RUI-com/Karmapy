// ignore_for_file: deprecated_member_use, prefer_const_constructors, file_names

import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'text-title.dart';

class ListItemp extends StatelessWidget {
  final String image;
  final String title;
  final Color backgroundcolor;
  final Color coloricon;
  final Color colortext;
  const ListItemp(
      {super.key,
      required this.image,
      required this.title,
      required this.backgroundcolor,
      required this.coloricon,
      required this.colortext});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: backgroundcolor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            image,
            color: coloricon,
            width: 20,
          ),
          SizedBox(
            width: 10,
          ),
          TextTitle(
              title: title,
              fontStyle: "PoppinsRegular",
              size: 12,
              colortext: colortext),
        ],
      ),
    );
  }
}
