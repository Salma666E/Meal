import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:meal/providers/meal_provider.dart';
import 'package:meal/screens/tabs_scrn.dart';
import 'package:provider/provider.dart';
import 'screens/category_meals_scrn.dart';
import 'screens/filters_scrn.dart';
import 'screens/meal_description.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(ChangeNotifierProvider<MealProvider>(
    create: (ctx) => MealProvider()
      ..getAdsBanner()
      ..getAdsBanner2()
      ..getRepeatedAd1()
      ..getRepeatedAd2(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meal App',
      themeMode: ThemeMode.light,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        buttonColor: Colors.black87,
        cardColor: Colors.white,
        shadowColor: Colors.black87,
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyText1: TextStyle(
              color: Color.fromRGBO(20, 50, 50, 1),
            ),
            headline6: TextStyle(
              color: Colors.black87,
              fontSize: 20,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
            )),
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(14, 22, 33, 1),
        fontFamily: 'Raleway',
        buttonColor: Colors.white70,
        cardColor: Color.fromRGBO(35, 34, 39, 1),
        shadowColor: Colors.white60,
        textTheme: ThemeData.dark().textTheme.copyWith(
            bodyText1: TextStyle(
              color: Colors.white60,
            ),
            headline6: TextStyle(
              color: Colors.white70,
              fontSize: 20,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
            )),
      ),
      routes: {
        '/': (context) => TabScrn(),
        CategoryMealsScrn.routName: (context) => CategoryMealsScrn(),
        MealDescription.routName: (context) => MealDescription(),
        FiltersScrn.routName: (context) => FiltersScrn(),
      },
    );
  }
}
