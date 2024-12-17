// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Theme/color.dart';
import 'main_controller.dart';
import 'screen/card_screen.dart';

import 'screen/products_screen.dart';
import 'screen/profile_screen.dart';
import 'homepage.dart';

class MainScreen extends StatelessWidget {
  final MainController controller = Get.put(MainController());

  final List<Widget> pages = [
    Homepage(),
    CardScreen(),
    ProductsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => pages[controller.selectedIndex.value]),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          backgroundColor: Colors.white,
          destinations: [
            NavigationDestination(
              icon: Icon(
                controller.selectedIndex.value == 0
                    ? Icons.home
                    : Icons.home_outlined,
                color: controller.selectedIndex.value == 0
                    ? primaryColor
                    : Colors.black,
              ),
              label: '',
            ),
            NavigationDestination(
              icon: Icon(
                controller.selectedIndex.value == 1
                    ? Icons.call_to_action_rounded
                    : Icons.credit_card,
                color: controller.selectedIndex.value == 1
                    ? primaryColor
                    : Colors.black,
              ),
              label: '',
            ),
            NavigationDestination(
              icon: Icon(
                controller.selectedIndex.value == 2
                    ? Icons.shopping_cart
                    : Icons.shopping_cart_outlined,
                color: controller.selectedIndex.value == 2
                    ? primaryColor
                    : Colors.black,
              ),
              label: '',
            ),
            NavigationDestination(
              icon: Icon(
                controller.selectedIndex.value == 3
                    ? Icons.person
                    : Icons.person_outline,
                color: controller.selectedIndex.value == 3
                    ? primaryColor
                    : Colors.black,
              ),
              label: '',
            ),
          ],
          indicatorColor: Colors.transparent,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (int index) {
            controller.updateIndex(index);
          },
        ),
      ),
    );
  }
}
