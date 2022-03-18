import 'package:flutter/material.dart';
import 'package:meal/providers/meal_provider.dart';
import 'package:meal/widgets/category_item.dart';
import 'package:provider/provider.dart';
import '../dummy_data.dart';
import 'tabs_scrn.dart';

class CategoriesScrn extends StatelessWidget {
  const CategoriesScrn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: GridView(
              padding: EdgeInsets.all(25.0),
              children: DUMMY_CATEGORIES
                  //to show item of list (DUMMY_CATEGORIES) as map
                  .map(
                    (catData) =>
                        CategoryItem(catData.id, catData.title, catData.color),
                  )
                  //to convert map to list
                  .toList(),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  mainAxisSpacing: 20,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 20),
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
    );
  }
}
