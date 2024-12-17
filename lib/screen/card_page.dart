// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Theme/color.dart';
import '../components/coustombuttonath.dart';
import '../controller/cart_controller.dart';

class CartPage extends StatelessWidget {
  final CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Text('Cart'),
        centerTitle: true,
        backgroundColor: background,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() => cartController.cartItems.isEmpty
          ? Center(child: Text('لا يوجد منتجات في السلة'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartController.cartItems.length,
                    itemBuilder: (context, index) {
                      var item = cartController.cartItems[index];
                      return Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(12),
                          leading: Image.network(
                            item['image'],
                            fit: BoxFit.cover,
                          ),
                          title: Text(
                            item['title'],
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            '\$${item['price']}',
                            style: TextStyle(color: primaryColor, fontSize: 14),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove, color: primaryColor),
                                onPressed: () {
                                  if (item['quantity'] > 1) {
                                    cartController.updateQuantity(
                                        item['id'], item['quantity'] - 1);
                                  }
                                },
                              ),
                              Text(item['quantity'].toString()),
                              IconButton(
                                icon: Icon(Icons.add, color: primaryColor),
                                onPressed: () {
                                  cartController.updateQuantity(
                                      item['id'], item['quantity'] + 1);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  cartController.removeFromCart(item['id']);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Subtotal :",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            ' \$${cartController.totalPrice.value.toStringAsFixed(2)}',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: primaryColor),
                          ),
                        ],
                      ),
                      Container(
                        width: double.infinity,
                        child: CoustomButtonAuth(
                          title: "Checkout",
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
    );
  }
}
