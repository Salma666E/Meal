import 'package:flutter/material.dart';
import 'package:meal/models/meal.dart';
import 'package:meal/providers/meal_provider.dart';
import 'package:provider/provider.dart';

import 'tabs_scrn.dart';

class MealDescription extends StatelessWidget {
  static const String routName = "MealDescription";
  @override
  Widget build(BuildContext context) {
    final routArg =
        ModalRoute.of(context)!.settings.arguments as Map<String, Meal>;
    final meal = routArg["item"];
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(meal!.title)),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          verticalDirection: VerticalDirection.down,
          children: [
            Container(
                height: 250,
                width: double.infinity,
                child: Image.network(
                  meal.imageUrl,
                  fit: BoxFit.cover,
                )),
            SizedBox(
              height: 5,
              width: double.infinity,
            ),
            Container(
                width: double.infinity,
                child: Text(
                  " Ingredients:",
                  style: Theme.of(context).textTheme.headline6,
                )),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              width: 300,
              height: 150,
              child: ListView.builder(
                itemBuilder: (ctx, index) => Card(
                    color: Theme.of(context).accentColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Text(meal.ingredients[index]),
                    )),
                itemCount: meal.ingredients.length,
              ),
            ),
            SizedBox(
              height: 5,
              width: double.infinity,
            ),
            Container(
                width: double.infinity,
                child: Text(
                  " Steps:",
                  style: Theme.of(context).textTheme.headline6,
                )),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              width: 300,
              height: 200,
              child: ListView.builder(
                itemBuilder: (ctx, index) => Card(
                    color: Theme.of(context).accentColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Text(
                          (index + 1).toString() + "-  " + meal.steps[index]),
                    )),
                itemCount: meal.steps.length,
              ),
            ),
             Container(
            height: 55.0,
            color: Colors.grey[900],
            child: checkForAd(
                Provider.of<MealProvider>(context, listen: true).isLoaded2,
                Provider.of<MealProvider>(context, listen: true).bannerAd2,
                context),
          )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Provider.of<MealProvider>(context, listen: false)
              .toggleFavorites(meal.id),
          child: Provider.of<MealProvider>(context, listen: true)
                  .isMealFavorite(meal.id)
              ? Icon(Icons.favorite)
              : Icon(Icons.favorite_border_outlined),
        ),
      ),
    );
  }
}
