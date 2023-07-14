import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_ui/constant/app_string.dart';
import 'package:flutter_food_delivery_ui/constant/app_text_style.dart';
import 'package:flutter_food_delivery_ui/models/restaurant.dart';
import 'package:flutter_food_delivery_ui/screens/home/widgets/rating_stars.dart';
import 'package:flutter_food_delivery_ui/screens/restaurant/widgets/menu_restaurant.dart';
import 'package:flutter_food_delivery_ui/screens/widgets/primary_button.dart';

class RestaurantScreen extends StatelessWidget {
  final Restaurant restaurant;
  const RestaurantScreen({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildRestaurantImageHeader(context),
          _buildRestaurantInfo(),
          _buildSupportButton(),
          Expanded(child: MenuRestaurant(menu: restaurant.menu))
        ],
      ),
    );
  }

  Widget _buildRestaurantImageHeader(BuildContext context) {
    return Stack(
      children: [
        _buildRestaurantImage(context),
        _buildBackButton(context),
        _buildLoveIconbutton()
      ],
    );
  }

  Widget _buildRestaurantImage(BuildContext context) {
    return Hero(
      tag: restaurant.imageUrl,
      child: Image.asset(
        restaurant.imageUrl,
        height: 220,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Positioned(
      left: 20,
      top: 50,
      child: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        iconSize: 30,
        color: Colors.white,
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  Widget _buildLoveIconbutton() {
    return Positioned(
      right: 20,
      top: 50,
      child: IconButton(
        icon: const Icon(Icons.favorite),
        iconSize: 35,
        color: Colors.deepOrangeAccent,
        onPressed: () {},
      ),
    );
  }

  Widget _buildRestaurantInfo() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 3,
                child: Text(
                  restaurant.name,
                  style: AppTextStyle.black22pxW600,
                ),
              ),
              const Flexible(
                flex: 2,
                child: Text(AppString.dummyDistance,
                    style: AppTextStyle.black18px),
              )
            ],
          ),
          RatingStars(rating: restaurant.rating),
          Text(restaurant.address, style: AppTextStyle.black18px),
        ],
      ),
    );
  }

  Widget _buildSupportButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        PrimaryButton(
          onPressed: () {},
          child: const Text(AppString.reviews),
        ),
        PrimaryButton(
          onPressed: () {},
          child: const Text(AppString.contact),
        ),
      ],
    );
  }
}
