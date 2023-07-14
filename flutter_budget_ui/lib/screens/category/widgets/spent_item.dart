import 'package:flutter/material.dart';
import 'package:flutter_budget_ui/constant/app_text_style.dart';
import 'package:flutter_budget_ui/models/expense_model.dart';

class SpentItem extends StatelessWidget {
  final Expense expense;
  const SpentItem({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(color: Colors.black12, offset: Offset(0, 2), blurRadius: 6)
        ],
      ),
      child: Row(
        children: [
          Expanded(child: Text(expense.name, style: AppTextStyle.red20pxBold)),
          Text(
            '-\$${expense.cost.toStringAsFixed(2)}',
            style: AppTextStyle.black20pxBold,
          ),
        ],
      ),
    );
  }
}
