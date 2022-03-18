import 'package:flutter/material.dart';

class MealRow extends StatelessWidget {
  const MealRow(this.icon, this.description);
  final String description;
  final icon;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        SizedBox(
          width: 6,
        ),
        Text(description)
      ],
    );
  }
}
