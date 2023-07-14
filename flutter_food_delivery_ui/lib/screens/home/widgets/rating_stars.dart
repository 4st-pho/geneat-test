import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final int rating;
  const RatingStars({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    if (rating <= 0 || rating > 5) return const SizedBox();
    return Text('⭐ ' * rating);
  }
}
