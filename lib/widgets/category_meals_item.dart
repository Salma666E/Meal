import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meal/models/meal.dart';
import 'package:meal/providers/meal_provider.dart';
import 'package:meal/screens/meal_description.dart';
import 'package:provider/provider.dart';

import 'meal_item_row.dart';

class CategoryMealsItem extends StatelessWidget {
  const CategoryMealsItem(this.categoryMeal);
  final Meal categoryMeal;
  void selectMeal(BuildContext ctx) {
    Navigator.of(ctx)
        .pushNamed(MealDescription.routName, arguments: {'item': categoryMeal});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () async {
          // if (Provider.of<MealProvider>(context, listen: true).interstited)
          //   await Provider.of<MealProvider>(context, listen: true)
          //       .interstitialAd
          //       .show();
          selectMeal(context);
        },
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 4,
          margin: EdgeInsets.all(18.0),
          shadowColor: Colors.grey[350],
          child: Column(children: [
            Stack(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Image.network(
                      categoryMeal.imageUrl,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )),
                Positioned(
                    left: 15,
                    bottom: 15,
                    child: Container(
                        padding: EdgeInsets.all(5.0),
                        width: 300,
                        color: Colors.black54,
                        child: Text(
                          categoryMeal.title,
                          style: TextStyle(color: Colors.white, fontSize: 24),
                          softWrap: true,
                        ))),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MealRow(Icons.schedule,
                      categoryMeal.duration.toString() + " min"),
                  MealRow(Icons.work, categoryMeal.complexityText),
                  MealRow(Icons.attach_money, categoryMeal.affordabilityText),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
