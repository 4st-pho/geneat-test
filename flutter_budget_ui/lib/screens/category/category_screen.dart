import 'package:flutter/material.dart';
import 'package:flutter_budget_ui/constant/app_text_style.dart';
import 'package:flutter_budget_ui/models/category_model.dart';
import 'package:flutter_budget_ui/screens/category/widgets/spent_item.dart';
import 'package:flutter_budget_ui/utils/radial_painter.dart';
import 'package:flutter_budget_ui/utils/status_color.dart';

class CategoryScreen extends StatelessWidget {
  final Category category;
  const CategoryScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    double totalAmountSpent = 0;
    for (var expense in category.expenses) {
      totalAmountSpent += expense.cost;
    }
    final double amountLeft = category.maxAmount - totalAmountSpent;
    final double percent = amountLeft / category.maxAmount;

    return Scaffold(
      appBar: _buildAppbar(context),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildCircularPercent(percent, amountLeft),
          ...category.expenses.map((e) => SpentItem(expense: e)).toList()
        ],
      ),
    );
  }

  AppBar _buildAppbar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: IconButton(
        iconSize: 30,
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(Icons.arrow_back_ios_rounded),
      ),
      title: Text(category.name),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.add), iconSize: 30)
      ],
    );
  }

  Widget _buildCircularPercent(double percent, double amountLeft) {
    return Container(
      width: double.infinity,
      height: 250,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(color: Colors.black12, offset: Offset(0, 2), blurRadius: 6)
        ],
      ),
      child: CustomPaint(
        foregroundPainter: RadialPainter(
          bgColor: Colors.grey.shade200,
          linerColor: getStatusColor(percent),
          percent: percent,
          width: 15,
        ),
        child: Center(
          child: Text(
            '\$${amountLeft.toStringAsFixed(2)} / \$${category.maxAmount}',
            style: AppTextStyle.black20pxW600,
          ),
        ),
      ),
    );
  }
}
