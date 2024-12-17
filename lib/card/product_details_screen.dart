// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../Theme/color.dart';
import '../components/coustombuttonath.dart';
import '../components/star-rating-example.dart';
import '../controller/cart_controller.dart';
import '../screen/card_page.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String productId; // تمرير ID المنتج

  const ProductDetailsScreen({required this.productId});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.put(CartController());
    CollectionReference productsRef =
        FirebaseFirestore.instance.collection('products'); // اسم المجموعة

    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<DocumentSnapshot>(
        future: productsRef.doc(productId).get(), // جلب المنتج بالـ ID
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('حدث خطأ أثناء تحميل البيانات'),
            );
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(
              child: Text('المنتج غير موجود'),
            );
          }

          // استخراج بيانات المنتج
          var product = snapshot.data!.data() as Map<String, dynamic>;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Image.network(
                      product['image'], // الصورة من الرابط
                      width: double.infinity,
                      height: 320,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 15,
                      left: 10,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          Get.toNamed('/homepage');
                        },
                      ),
                    ),
                    Positioned(
                      top: 15,
                      right: 10,
                      child: Container(
                        child: IconButton(
                          onPressed: () {
                            Get.to(CartPage());
                          },
                          icon: Icon(Icons.shopping_bag_rounded),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(17.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              product['title'],
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '\$${product['price']}',
                              style: TextStyle(
                                fontSize: 20,
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        StarRatingExample(),
                        Container(
                          height: 125,
                          child: ListView(
                            children: [
                              Text(
                                'Description',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                product['description'],
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5),
                        Center(
                          child: Container(
                            width: double.infinity,
                            child: CoustomButtonAuth(
                              title: 'add to cart',
                              onPressed: () {
                                cartController.addToCart(
                                  productId,
                                  product['title'],
                                  (product['price'] as num).toDouble(),
                                  product['image'],
                                );
                                Get.snackbar(
                                  'تم الإضافة',
                                  'تمت إضافة المنتج إلى السلة',
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.green,
                                  colorText: Colors.white,
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
