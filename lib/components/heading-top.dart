// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screen/card_page.dart';

class HeadingTop extends StatelessWidget {
  const HeadingTop({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //menu button
          Builder(builder: (context) {
            return IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: Icon(Icons.menu));
          }),
          // logo world
          Container(
              child: Text(
            "Karmapay",
            style: TextStyle(fontSize: 18),
          )),
          //shope button
          IconButton(
            onPressed: () {
              Get.to(CartPage());
            },
            icon: Icon(Icons.shopping_bag_rounded),
          ),
        ],
      ),
    );
  }
}
