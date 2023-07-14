import 'package:flutter/material.dart';

class ProfileBackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final startpoint = Offset(0, size.height * 4 / 5);
    final point1 = Offset(size.width * 1 / 2, size.height);
    final point2 = Offset(size.width, size.height * 4 / 5);
    final endPoint = Offset(size.width, 0);

    path.lineTo(startpoint.dx, startpoint.dy);
    path.quadraticBezierTo(point1.dx, point1.dy, point2.dx, point2.dy);
    path.lineTo(endPoint.dx, endPoint.dy);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
