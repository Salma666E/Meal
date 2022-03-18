import 'package:flutter/material.dart';
import 'package:meal/models/meal.dart';
import 'package:meal/providers/meal_provider.dart';
import 'package:meal/screens/tabs_scrn.dart';
import 'package:meal/widgets/category_meals_item.dart';
import 'package:provider/provider.dart';

class CategoryMealsScrn extends StatefulWidget {
  static const routName = "CategoryMeals";

  @override
  _CategoryMealsScrnState createState() => _CategoryMealsScrnState();
}

class _CategoryMealsScrnState extends State<CategoryMealsScrn> {
  @override
  Widget build(BuildContext context) {
    final List<Meal> _avalibleMeals =
        Provider.of<MealProvider>(context, listen: true).avalibleMeals;
    final routArg =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final catId = routArg["id"];
    final catTitle = routArg["title"];
    final categoryMeals = _avalibleMeals.where((meal) {
      return meal.categories.contains(catId);
    }).toList();
    return Scaffold(
      appBar: AppBar(title: Text(catTitle.toString())),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, index) {
                return CategoryMealsItem(
                    categoryMeals[index]); //Text(categoryMeals[index].title);
              },
              itemCount: categoryMeals.length,
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
      ),
    );
  }
}
