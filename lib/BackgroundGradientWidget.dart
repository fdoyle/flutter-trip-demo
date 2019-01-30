import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BackgroundGradientWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      foregroundDecoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          const Color(0xFFD2C1D6), Colors.transparent
        ],
        begin: Alignment.topRight,
        end: Alignment.center)
      ),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [const Color(0xFF9590DB), const Color(0xFF843B65)])));

  }
}
