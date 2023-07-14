import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_ui/constant/app_string.dart';
import 'package:flutter_food_delivery_ui/constant/app_text_style.dart';
import 'package:flutter_food_delivery_ui/data/data.dart';
import 'package:flutter_food_delivery_ui/screens/cart/card_screen.dart';
import 'package:flutter_food_delivery_ui/screens/home/widgets/nearby_restaurant.dart';
import 'package:flutter_food_delivery_ui/screens/home/widgets/recent_order.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: ListView(
        children: [
          _buildSearchBar(),
          const RecentOrder(),
          const NearbyRestaurant(),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
          hintText: AppString.searchFoodOrRestaurants,
          prefixIcon: const Icon(Icons.search),
          suffixIcon: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.clear),
          ),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(width: 0.8),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              width: 0.8,
              color: Colors.deepOrangeAccent,
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      title: const Text(AppString.foodDelivery),
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.account_circle),
        iconSize: 30,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const CartScreen()),
            );
          },
          child: Text(
            'Card (${currentUser.cart.length})',
            style: AppTextStyle.white20px,
          ),
        )
      ],
    );
  }
}
