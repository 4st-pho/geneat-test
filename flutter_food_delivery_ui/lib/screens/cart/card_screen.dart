import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_ui/constant/app_string.dart';
import 'package:flutter_food_delivery_ui/constant/app_text_style.dart';
import 'package:flutter_food_delivery_ui/data/data.dart';
import 'package:flutter_food_delivery_ui/screens/cart/widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context),
      body: ListView.separated(
        padding:
            const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 120),
        itemBuilder: (context, index) {
          final cart = currentUser.cart;
          final order = cart[index];
          if (index == cart.length - 1) {
            return _buildTimeAndCostInfo();
          }
          return CartItem(order: order);
        },
        separatorBuilder: (_, __) =>
            Divider(color: Colors.grey.shade200, indent: 1, height: 30),
        itemCount: currentUser.cart.length,
      ),
      bottomSheet: _buildCheckoutButton(),
    );
  }

  Widget _buildTimeAndCostInfo() {
    double totalCost = 0;
    for (var e in currentUser.cart) {
      totalCost += e.quantity * e.food.price;
    }
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              AppString.estimatedDeliveryTime,
              style: AppTextStyle.black20pxW600,
            ),
            Text(AppString.dummyMinute, style: AppTextStyle.black20pxW600),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(AppString.totalCost, style: AppTextStyle.black20pxW600),
            Text(
              totalCost.toStringAsFixed(2),
              style: AppTextStyle.green70020pxW600,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCheckoutButton() {
    return InkWell(
      onTap: () {},
      child: Container(
        width: double.infinity,
        height: 100,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.deepOrangeAccent,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -1),
              blurRadius: 6,
              color: Colors.black26,
            ),
          ],
        ),
        child: const Text(
          AppString.checkOut,
          style: AppTextStyle.white22pxBoldLt2,
        ),
      ),
    );
  }

  AppBar _buildAppbar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        iconSize: 30,
        color: Colors.white,
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text('Cart (${currentUser.cart.length})'),
    );
  }
}
