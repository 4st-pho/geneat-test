import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_ui/constant/app_text_style.dart';
import 'package:flutter_food_delivery_ui/models/order.dart';
import 'package:flutter_food_delivery_ui/screens/widgets/circular_icon_button.dart';

class RecentOrderItem extends StatelessWidget {
  final Order order;
  const RecentOrderItem({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: 320,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200, width: 1),
        color: Colors.white,
      ),
      child: Row(
        children: [
          _buildOrderItemImage(order),
          Expanded(
            child: _buildOrderItemInfo(order),
          ),
          _buildOrderButton()
        ],
      ),
    );
  }

  Widget _buildOrderItemImage(Order order) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.asset(
        order.food.imageUrl,
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildOrderItemInfo(Order order) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            order.food.name,
            style: AppTextStyle.black18pxBold,
            overflow: TextOverflow.ellipsis,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(
              order.restaurant.name,
              style: AppTextStyle.black16pxW600,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            order.date,
            style: AppTextStyle.black16pxW600,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildOrderButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: CircularIconButton(iconData: Icons.add, onPressed: () {}),
    );
  }
}
