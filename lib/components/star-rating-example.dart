// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class StarRatingExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // عنصر التقييم باستخدام RatingBar
            RatingBarIndicator(
              rating: 4.5, // التقييم
              itemBuilder: (context, index) => Icon(
                Icons.star,
                color: Colors.orange, // لون النجوم
              ),
              itemCount: 5, // العدد الإجمالي للنجوم
              itemSize: 20, // حجم النجوم
              direction: Axis.horizontal,
            ),
            SizedBox(width: 5),
            // نص التقييم بجانب النجوم
            Text(
              "4.5",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
