import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_ui/constant/app_string.dart';
import 'package:flutter_food_delivery_ui/constant/app_text_style.dart';
import 'package:flutter_food_delivery_ui/models/order.dart';

class CartItem extends StatelessWidget {
  final Order order;
  const CartItem({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildCartItemImage(order),
        const SizedBox(width: 10),
        Expanded(child: _buildCardOrderInfo(order)),
        _buildCartItemPrice(order)
      ],
    );
  }

  Widget _buildCartItemImage(Order order) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.asset(
        order.food.imageUrl,
        width: 150,
        height: 150,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildCardOrderInfo(Order order) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(order.food.name, style: AppTextStyle.black20pxBold),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(order.restaurant.name, style: AppTextStyle.black16pxW600),
        ),
        _buildCartOrderQuantity(order),
      ],
    );
  }

  Widget _buildCartOrderQuantity(Order order) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 0.8, color: Colors.black54),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {},
            child: const Text(AppString.minus,
                style: AppTextStyle.deepOrangeAccent20pxW600),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text('${order.quantity}', style: AppTextStyle.black20pxW600),
          ),
          InkWell(
            onTap: () {},
            child: const Text(
              AppString.plus,
              style: AppTextStyle.deepOrangeAccent20pxW600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItemPrice(Order order) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        '\$${order.food.price * order.quantity}',
        style: AppTextStyle.black16pxW600,
      ),
    );
  }
}
