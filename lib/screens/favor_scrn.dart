import 'package:flutter/material.dart';
import 'package:meal/providers/meal_provider.dart';
import 'package:meal/models/meal.dart';
import 'package:meal/widgets/category_meals_item.dart';
import 'package:provider/provider.dart';

import 'tabs_scrn.dart';

class FavoritesScrn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Meal> favMaelList =
        Provider.of<MealProvider>(context, listen: true).favoriteMeals;
    if (favMaelList.isEmpty) {
      return Center(
        child: Text("You hava no favorites yet - start sdding come!"),
      );
    } else {
      return Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, index) {
                return CategoryMealsItem(
                    favMaelList[index]); //Text(categoryMeals[index].title);
              },
              itemCount: favMaelList.length,
            ),
          ),
          Container(
            height: 55.0,
            color: Colors.grey[900],
            child: checkForAd(
                Provider.of<MealProvider>(context, listen: true).isLoaded1,
                Provider.of<MealProvider>(context, listen: true).bannerAd1,
                context),
          )
        ],
      );
    }
  }
}
