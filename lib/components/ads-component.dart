// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, library_private_types_in_public_api, file_names
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';

import '../Theme/color.dart';

class EndOfYearSale extends StatefulWidget {
  @override
  _EndOfYearSaleState createState() => _EndOfYearSaleState();
}

class _EndOfYearSaleState extends State<EndOfYearSale> {
  final List<String> imageUrls = [
    'https://eg.jumia.is/cms/DEC-24/CATS/Phones/AndroidPhones/4199/712x384AR.png',
    'https://eg.jumia.is/cms/DEC-24/CATS/Beauty/SkinCare/712x384AR.png',
    'https://eg.jumia.is/cms/DEC-24/CATS/Home/HomeOrganization/712x384AR.jpg',
    'https://eg.jumia.is/cms/DEC-24/CATS/Christmas/SL712X384AR.png',
  ];

  // المتغير لمراقبة الصفحة الحالية
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Carousel Slider للصور
        CarouselSlider(
          options: CarouselOptions(
            height: 160,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 10),
            enlargeCenterPage: true,
            aspectRatio: 16 / 9,
            viewportFraction: 0.9,
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index; // تحديث الصفحة الحالية
              });
            },
          ),
          items: imageUrls.map((url) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(url),
                  fit: BoxFit.fill,
                ),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 10),
        // مؤشر النقاط DotsIndicator
        DotsIndicator(
          dotsCount: imageUrls.length,
          position: currentIndex,
          decorator: DotsDecorator(
            color: Colors.grey, // لون النقاط الغير مفعّلة
            activeColor: primaryColor, // لون النقاط المفعّلة
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
      ],
    );
  }
}
