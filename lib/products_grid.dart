// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'card/product_card.dart';

class ProductsGrid extends StatefulWidget {
  final String selectedCategory;

  ProductsGrid({required this.selectedCategory});

  @override
  _ProductsGridState createState() => _ProductsGridState();
}

class _ProductsGridState extends State<ProductsGrid> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('products')
          .where('categories',
              isEqualTo:
                  widget.selectedCategory) // تطابق مع القيم باللغة العربية
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          debugPrint("عدد المنتجات: ${snapshot.data!.docs.length}");
          debugPrint("التصنيف المختار: ${widget.selectedCategory}");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('حدث خطأ أثناء جلب البيانات'));
        }

        final products = snapshot.data!.docs;

        if (products.isEmpty) {
          return Center(child: Text('لا توجد منتجات ضمن هذا التصنيف'));
        }

        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 0.6,
          ),
          padding: EdgeInsets.all(12),
          itemCount: products.length,
          itemBuilder: (context, index) {
            var product = products[index].data() as Map<String, dynamic>;
            double price = (product['price'] is int)
                ? (product['price'] as int).toDouble()
                : product['price'].toDouble();
            return ProductCard(
              title: product['title'],
              price: price,
              imageUrl: product['image'],
              productId: products[index].id,
            );
          },
        );
      },
    );
  }
}
