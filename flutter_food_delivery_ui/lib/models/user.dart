import 'package:flutter_food_delivery_ui/models/order.dart';

class User {
  final String name;
  final List<Order> orders;
  final List<Order> cart;

  User({
    required this.name,
    required this.cart,
    required this.orders,
  });
}
