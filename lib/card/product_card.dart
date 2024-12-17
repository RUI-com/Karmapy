// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Theme/color.dart';
import '../controller/cart_controller.dart';
import 'product_details_screen.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final double price;
  final String imageUrl;
  final String productId;

  ProductCard({
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.productId,
  });

  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 6,
      child: Container(
        padding: EdgeInsets.all(5),
        width: 200,
        height: 241,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {
                Get.to(() => ProductDetailsScreen(productId: productId));
              },
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: Stack(
                    children: [
                      Image.network(
                        imageUrl,
                        width: double.infinity,
                        height: 160, // حجم الصورة
                        fit: BoxFit.cover,
                      ),
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.red),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.favorite_outlined,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                      )
                    ],
                  )),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 15, // حجم الخط العنوان
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '\$${price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: IconButton(
                    onPressed: () {
                      cartController.addToCart(
                          productId, title, price, imageUrl);
                    },
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
