// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'categories_bar.dart';
import 'components/ads-component.dart';
import 'components/heading-top.dart';
import 'components/sidebar-menu.dart';
import 'products_grid.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String selectedCategory = 'ازياء'; // التصنيف الافتراضي

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SidebarMenu(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Expanded(
          child: Column(
            children: [
              // رأس الصفحة
              HeadingTop(),
              //شريط الاعلانات
              EndOfYearSale(),

              // شريط التصنيفات
              CategoriesBar(
                onCategorySelected: (categoryKey) {
                  setState(() {
                    selectedCategory = categoryKey; // تغيير التصنيف المختار
                  });
                },
              ),
              Container(
                padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Newest Deals",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              // الشبكة لعرض المنتجات
              Expanded(
                child: ProductsGrid(
                    selectedCategory:
                        selectedCategory), // تمرير التصنيف المختار للشبكة
              ),
            ],
          ),
        ),
      ),
    );
  }
}
