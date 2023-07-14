import 'package:flutter/material.dart';
import 'package:flutter_budget_ui/constant/app_colors.dart';
import 'package:flutter_budget_ui/constant/app_text_style.dart';

class BarChartItem extends StatelessWidget {
  final String lable;
  final double amountSpent;
  final double mostExpensive;
  final _maxBarHeight = 150;

  const BarChartItem({
    super.key,
    required this.lable,
    required this.amountSpent,
    required this.mostExpensive,
  });

  @override
  Widget build(BuildContext context) {
    final barHeight = amountSpent / mostExpensive * _maxBarHeight;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FittedBox(child: Text(amountSpent.toStringAsFixed(2))),
          Padding(
            padding: const EdgeInsets.only(top: 6, bottom: 8),
            child: FittedBox(
              child: Container(
                height: barHeight,
                width: 18,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ),
          FittedBox(child: Text(lable, style: AppTextStyle.black16pxW600))
        ],
      ),
    );
  }
}
