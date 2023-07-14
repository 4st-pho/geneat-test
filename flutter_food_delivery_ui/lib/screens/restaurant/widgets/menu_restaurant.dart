import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_ui/constant/app_string.dart';
import 'package:flutter_food_delivery_ui/constant/app_text_style.dart';
import 'package:flutter_food_delivery_ui/models/food.dart';
import 'package:flutter_food_delivery_ui/screens/widgets/circular_icon_button.dart';

class MenuRestaurant extends StatelessWidget {
  final List<Food> menu;
  const MenuRestaurant({super.key, required this.menu});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(AppString.menu, style: AppTextStyle.black24pxW600Ls12),
        ),
        Expanded(
          child: GridView(
              padding: const EdgeInsets.all(20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
              ),
              children: menu.map((food) => _buildFoodItem(food)).toList()),
        )
      ],
    );
  }

  Widget _buildFoodItem(Food food) {
    return Stack(
      children: [
        _buildFoodImage(food),
        _buildFoodNameAndPrice(food),
        _buildAddFoodButton()
      ],
    );
  }

  Widget _buildAddFoodButton() {
    return Positioned(
      bottom: 10,
      right: 10,
      child: CircularIconButton(
        iconData: Icons.add,
        onPressed: () {},
      ),
    );
  }

  Widget _buildFoodNameAndPrice(Food food) {
    return Positioned.fill(
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.black.withOpacity(0.3),
              Colors.black87.withOpacity(0.3),
              Colors.black54.withOpacity(0.3),
              Colors.black38.withOpacity(0.3),
            ],
            stops: const [0.1, 0.4, 0.6, 0.9],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(
              child: Text(
                food.name,
                style: AppTextStyle.white24pxBoldLs12,
              ),
            ),
            FittedBox(
              child: Text(
                '\$${food.price}',
                style: AppTextStyle.white18pxBoldLs12,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildFoodImage(Food food) {
    return AspectRatio(
      aspectRatio: 1,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.asset(
          food.imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
