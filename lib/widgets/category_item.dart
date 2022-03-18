import 'package:flutter/material.dart';
import 'package:meal/providers/meal_provider.dart';
import 'package:meal/screens/category_meals_scrn.dart';
import 'package:provider/provider.dart';

class CategoryItem extends StatelessWidget {
  CategoryItem(this.id, this.title, this.color);
  final String id;
  final String title;
  final Color color;
  void selectCategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(CategoryMealsScrn.routName,
        arguments: {'id': id, 'title': title});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        // if (Provider.of<MealProvider>(context, listen: true).interstited)
        //   await Provider.of<MealProvider>(context, listen: true)
        //       .interstitialAd
        //       .show();
        selectCategory(context);
      },
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            // color: color,
            gradient: LinearGradient(
              colors: [color.withOpacity(0.5), color],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10)),
        child: Text(title, style: Theme.of(context).textTheme.headline6),
      ),
    );
  }
}
