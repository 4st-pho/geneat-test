import 'package:flutter/material.dart';
import 'package:flutter_social_ui/constant/app_colors.dart';

class LoginTextField extends StatelessWidget {
  final TextEditingController? controller;
  final Widget prefixIcon;
  final String hintText;
  final bool obscureText;
  const LoginTextField({
    super.key,
    this.controller,
    required this.prefixIcon,
    required this.hintText,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: Colors.white,
        filled: true,
        prefixIcon: prefixIcon,
        contentPadding: const EdgeInsets.symmetric(vertical: 15),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.secondary),
        ),
      ),
    );
  }
}
