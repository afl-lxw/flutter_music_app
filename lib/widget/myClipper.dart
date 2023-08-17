// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class MyClipper extends CustomClipper<Path> {
  MyClipper({
    required this.borderRadius,
  });
  final BorderRadius borderRadius;

  @override
  Path getClip(Size size) {
    final path = Path();

    path.addRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(0, 0, size.width, size.height),
        topLeft: borderRadius.topLeft,
        topRight: borderRadius.topRight,
        bottomLeft: borderRadius.bottomLeft,
        bottomRight: borderRadius.bottomRight,
      ),
    );

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
