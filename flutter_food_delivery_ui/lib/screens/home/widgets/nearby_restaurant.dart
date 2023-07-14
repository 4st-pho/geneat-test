import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_ui/constant/app_string.dart';
import 'package:flutter_food_delivery_ui/constant/app_text_style.dart';
import 'package:flutter_food_delivery_ui/data/data.dart';
import 'package:flutter_food_delivery_ui/models/restaurant.dart';
import 'package:flutter_food_delivery_ui/screens/home/widgets/rating_stars.dart';
import 'package:flutter_food_delivery_ui/screens/restaurant/restaurant_screen.dart';

class NearbyRestaurant extends StatelessWidget {
  const NearbyRestaurant({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            AppString.nearbyRestaurants,
            style: AppTextStyle.black24pxW600Ls12,
          ),
        ),
        ...restaurants.map(
          (restaurant) => InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      RestaurantScreen(restaurant: restaurant),
                ),
              );
            },
            child: _buildRestaurantItem(restaurant),
          ),
        )
      ],
    );
  }

  Widget _buildRestaurantItem(Restaurant restaurant) {
    return Container(
      height: 150,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(width: 1, color: Colors.grey.shade200),
        color: Colors.white,
      ),
      child: Row(
        children: [
          _buildRestaurantImage(restaurant),
          Expanded(child: _buildRestaurantInfo(restaurant))
        ],
      ),
    );
  }

  Widget _buildRestaurantImage(Restaurant restaurant) {
    return Hero(
      tag: restaurant.imageUrl,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.asset(
          restaurant.imageUrl,
          width: 150,
          height: 150,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildRestaurantInfo(Restaurant restaurant) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(
            child: Text(
              restaurant.name,
              style: AppTextStyle.black20pxBold,
            ),
          ),
          const SizedBox(height: 4),
          RatingStars(rating: restaurant.rating),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(
              restaurant.address,
              style: AppTextStyle.black16pxW400,
            ),
          ),
          const Text(
            AppString.dummyDistance,
            style: AppTextStyle.black16pxW400,
          ),
        ],
      ),
    );
  }
}
