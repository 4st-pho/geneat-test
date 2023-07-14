import 'package:flutter/material.dart';

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final startpoint = Offset(0, size.height * 4 / 5);
    final point1 = Offset(size.width * 1 / 4, size.height);
    final point2 = Offset(size.width * 1 / 2, size.height * 4 / 5);
    final point3 = Offset(size.width * 3 / 4, size.height * 3 / 5);
    final point4 = Offset(size.width, size.height * 4 / 5);
    final endPoint = Offset(size.width, 0);

    path.lineTo(startpoint.dx, startpoint.dy);
    path.quadraticBezierTo(point1.dx, point1.dy, point2.dx, point2.dy);
    path.quadraticBezierTo(point3.dx, point3.dy, point4.dx, point4.dy);
    path.lineTo(endPoint.dx, endPoint.dy);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
