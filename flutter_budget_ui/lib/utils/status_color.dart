import 'package:flutter/material.dart';
import 'package:flutter_budget_ui/constant/app_colors.dart';

Color getStatusColor(double percent) {
  if (percent >= 0.5) {
    return AppColors.primary;
  } else if (percent >= 0.25) {
    return Colors.orange;
  }
  return Colors.red;
}
