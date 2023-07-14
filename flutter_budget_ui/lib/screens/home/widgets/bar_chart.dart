import 'package:flutter/material.dart';
import 'package:flutter_budget_ui/constant/app_string.dart';
import 'package:flutter_budget_ui/constant/app_text_style.dart';
import 'package:flutter_budget_ui/data/data.dart';
import 'package:flutter_budget_ui/screens/home/widgets/bar_chart_item.dart';
import 'package:flutter_budget_ui/extensions/list_extension.dart';

class BarChart extends StatelessWidget {
  final List<double> amounts;
  const BarChart({super.key, required this.amounts});

  @override
  Widget build(BuildContext context) {
    final double mostExpensive = amounts.fold(
        0, (preValue, curValue) => preValue > curValue ? preValue : curValue);

    return Column(
      children: [
        const SizedBox(height: 10),
        const Text(
          AppString.weeklySpending,
          style: AppTextStyle.black20pxBoldLs12,
        ),
        _buildRangeTimeLable(),
        _buildChart(mostExpensive)
      ],
    );
  }

  Widget _buildRangeTimeLable() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            iconSize: 30,
            onPressed: () {},
            icon: const Icon(Icons.arrow_back),
          ),
          const Flexible(
            child: FittedBox(
              child: Text(
                AppString.dummyTime,
                style: AppTextStyle.black18pxW600Ls12,
              ),
            ),
          ),
          IconButton(
            iconSize: 30,
            onPressed: () {},
            icon: const Icon(Icons.arrow_forward),
          ),
        ],
      ),
    );
  }

  Widget _buildChart(double mostExpensive) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: daysLabel
          .mapIndexed(
            (element, index) => Flexible(
              child: FittedBox(
                child: BarChartItem(
                    lable: element,
                    amountSpent: amounts[index],
                    mostExpensive: mostExpensive),
              ),
            ),
          )
          .toList(),
    );
  }
}
