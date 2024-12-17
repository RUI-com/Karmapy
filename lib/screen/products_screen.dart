// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, library_private_types_in_public_api, use_key_in_widget_constructors, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../card/product_card.dart';
import '../components/search_textfiled.dart';
import 'card_page.dart';

class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController _searchController = TextEditingController();
  String? _searchTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: Color(0xFFF7F7F7),
        title: Text(
          'All Products',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(CartPage());
            },
            icon: Icon(Icons.shopping_bag_rounded),
          ),
        ],
        centerTitle: true,
      ),
      body: Column(
        children: [
          // إضافة TextField للبحث

          SearchTextfiled(
            controller: _searchController,
            onChanged: (value) {
              setState(() {
                _searchTitle = value.isNotEmpty ? value : null;
              });
            },
            onPressed: () {
              setState(() {
                _searchTitle = _searchController.text.isNotEmpty
                    ? _searchController.text
                    : null;
              });
            },
          ),

          // عرض المنتجات بناءً على البحث
          Expanded(
            child: StreamBuilder(
              stream: _buildQuery(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                var products = snapshot.data!.docs;
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 2,
                    childAspectRatio: 0.6,
                  ),
                  padding: EdgeInsets.all(12),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    var product = products[index];
                    double price = (product['price'] is int)
                        ? (product['price'] as int).toDouble()
                        : product['price'].toDouble();
                    return ProductCard(
                      title: product['title'],
                      price: price,
                      imageUrl: product['image'],
                      productId: product.id,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Stream<QuerySnapshot> _buildQuery() {
    Query query = _firestore.collection('products');

    // إضافة فلاتر البحث حسب العنوان بشكل عام
    if (_searchTitle != null && _searchTitle!.isNotEmpty) {
      query = query
          .orderBy('title')
          .startAt([_searchTitle]) // بدء البحث من الكلمة المدخلة
          .endAt([
        _searchTitle! + '\uf8ff'
      ]); // نهاية البحث بعد الكلمة المدخلة مع باقي الأحرف
    }

    return query.snapshots();
  }
}
