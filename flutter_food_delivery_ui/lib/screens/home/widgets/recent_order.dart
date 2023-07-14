import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_ui/constant/app_string.dart';
import 'package:flutter_food_delivery_ui/constant/app_text_style.dart';
import 'package:flutter_food_delivery_ui/data/data.dart';
import 'package:flutter_food_delivery_ui/screens/home/widgets/recent_order_item.dart';

class RecentOrder extends StatelessWidget {
  const RecentOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(),
        _buildListRecentOrder(),
      ],
    );
  }

  Widget _buildTitle() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        AppString.recentOrders,
        style: AppTextStyle.black24pxW600Ls12,
      ),
    );
  }

  Widget _buildListRecentOrder() {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: currentUser.orders.length,
        itemBuilder: (context, index) {
          final order = currentUser.orders[index];
          return RecentOrderItem(order: order);
        },
      ),
    );
  }
}
