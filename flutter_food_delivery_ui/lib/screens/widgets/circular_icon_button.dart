import 'package:flutter/material.dart';

class CircularIconButton extends StatelessWidget {
  final IconData iconData;
  final VoidCallback? onPressed;
  const CircularIconButton(
      {super.key, required this.iconData, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.deepOrangeAccent,
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(iconData),
        iconSize: 30,
        color: Colors.white,
      ),
    );
  }
}
