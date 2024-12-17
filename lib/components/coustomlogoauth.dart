import 'package:flutter/material.dart';

class Coustomlogoauth extends StatelessWidget {
  const Coustomlogoauth({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        width: 80,
        height: 80,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(70)),
        child: Image.asset(
          "assets/logo/flutter.png",
          height: 40,
        ),
      ),
    );
  }
}
