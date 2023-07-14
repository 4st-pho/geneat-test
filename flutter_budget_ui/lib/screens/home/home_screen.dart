import 'package:flutter/material.dart';
import 'package:flutter_budget_ui/constant/app_string.dart';
import 'package:flutter_budget_ui/constant/app_text_style.dart';
import 'package:flutter_budget_ui/data/data.dart';
import 'package:flutter_budget_ui/models/category_model.dart';
import 'package:flutter_budget_ui/screens/category/category_screen.dart';
import 'package:flutter_budget_ui/screens/home/widgets/bar_chart.dart';
import 'package:flutter_budget_ui/utils/status_color.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildSliverAppbar(),
          _buildBarChart(),
          _buildListSpentByCategories()
        ],
      ),
    );
  }

  Widget _buildSliverAppbar() {
    return SliverAppBar(
      expandedHeight: 100,
      forceElevated: true,
      pinned: true,
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.settings),
        iconSize: 30,
      ),
      flexibleSpace: const FlexibleSpaceBar(
        title: Text(AppString.simpleBudget),
        centerTitle: true,
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.add),
          iconSize: 30,
        ),
      ],
    );
  }

  Widget _buildBarChart() {
    return SliverPadding(
      padding: const EdgeInsets.all(20),
      sliver: SliverToBoxAdapter(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 2),
                blurRadius: 6,
              )
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          child: BarChart(amounts: weeklySpending),
        ),
      ),
    );
  }

  Widget _buildListSpentByCategories() {
    return SliverPadding(
      padding: const EdgeInsets.all(20),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final category = categories[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: _buildcategoryItem(context, category),
            );
          },
          childCount: categories.length,
        ),
      ),
    );
  }

  Widget _buildcategoryItem(BuildContext context, Category category) {
    double totalAmountSpent = 0;
    for (var expense in category.expenses) {
      totalAmountSpent += expense.cost;
    }

    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CategoryScreen(category: category)));
      },
      child: Container(
        height: 100,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 2),
              blurRadius: 6,
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSpentDetail(category, totalAmountSpent),
            const SizedBox(height: 10),
            _buildPercentBar(category, totalAmountSpent)
          ],
        ),
      ),
    );
  }

  Widget _buildSpentDetail(Category category, double totalAmountSpent) {
    return Row(
      children: [
        Expanded(
          child: Text(category.name, style: AppTextStyle.black20pxW600),
        ),
        const SizedBox(width: 4),
        Text(
          '\$${(category.maxAmount - totalAmountSpent).toStringAsFixed(2)} / \$${category.maxAmount}',
          style: AppTextStyle.black18pxW600,
        )
      ],
    );
  }

  Widget _buildPercentBar(Category category, double totalAmountSpent) {
    final percent =
        (category.maxAmount - totalAmountSpent) / category.maxAmount;
    return Container(
      height: 20,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(15),
      ),
      child: FractionallySizedBox(
        heightFactor: 1,
        widthFactor: percent,
        alignment: Alignment.centerLeft,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: getStatusColor(percent),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
