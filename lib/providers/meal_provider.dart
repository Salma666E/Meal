import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:meal/ad_helper.dart';
import 'package:meal/models/meal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../dummy_data.dart';

class MealProvider with ChangeNotifier {
  late BannerAd bannerAd1;
  bool isLoaded1 = false;
  late BannerAd bannerAd2;
  bool isLoaded2 = false;
  late InterstitialAd interstitialAd;
  bool interstited = false;
  late Timer _timerForAd1, _timerForAd2;
  getAdsBanner() {
    bannerAd1 = bannerCustom(AdManager.bannerAdUnitId, (_) {
      isLoaded1 = true;
      notifyListeners();
    });
    bannerAd1.load();
  }

  getAdsBanner2() {
    bannerAd2 = bannerCustom(AdManager.bannerAdUnitId2, (_) {
      isLoaded2 = true;
      notifyListeners();
    });
    bannerAd2.load();
  }

  getRepeatedAd1() {
    _timerForAd1 = Timer.periodic(const Duration(seconds: 20), (result) {
      isLoaded1 = false;
      bannerAd1 = bannerCustom(AdManager.bannerAdUnitId, (_) {
        isLoaded1 = true;
        notifyListeners();
      });
      bannerAd1.load();
    });
  }

  getRepeatedAd2() {
    _timerForAd2 = Timer.periodic(const Duration(seconds: 20), (result) {
      isLoaded2 = false;
      bannerAd2 = bannerCustom(AdManager.bannerAdUnitId2, (_) {
        isLoaded2 = true;
        notifyListeners();
      });
      bannerAd2.load();
    });
  }

  // getAdsInterstitial() {
  //   InterstitialAd.load(
  //       adUnitId: AdManager.interstitialAdUnitId,
  //       request: const AdRequest(),
  //       adLoadCallback: InterstitialAdLoadCallback(
  //         onAdLoaded: (InterstitialAd ad) {
  //           interstited = true;
  //           interstitialAd = ad;
  //           notifyListeners();
  //           interstitialAd.fullScreenContentCallback =
  //               FullScreenContentCallback(
  //             onAdShowedFullScreenContent: (InterstitialAd ad) =>
  //                 print('%ad onAdShowedFullScreenContent.'),
  //             onAdDismissedFullScreenContent: (InterstitialAd ad) {
  //               print('$ad onAdDismissedFullScreenContent.');
  //               ad.dispose();
  //             },
  //             onAdFailedToShowFullScreenContent:
  //                 (InterstitialAd ad, AdError error) {
  //               print('$ad onAdFailedToShowFullScreenContent: $error');
  //               ad.dispose();
  //             },
  //             onAdImpression: (InterstitialAd ad) =>
  //                 print('$ad impression occurred.'),
  //           );
  //         },
  //         onAdFailedToLoad: (LoadAdError error) {
  //           print('InterstitialAd failed to load: $error');
  //         },
  //       ));
  // }

  Map<String, bool> filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false
  };
  List<Meal> avalibleMeals = DUMMY_MEALS;

  void setFilters() async {
    avalibleMeals = DUMMY_MEALS.where((meal) {
      if (filters['gluten'] == true && !meal.isGlutenFree) {
        return false;
      }
      if (filters['lactose'] == true && !meal.isLactoseFree) {
        return false;
      }
      if (filters['vegan'] == true && !meal.isVegan) {
        return false;
      }
      if (filters['vegetarian'] == true && !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('gluten', filters['gluten'] as bool);
    prefs.setBool('lactose', filters['lactose'] as bool);
    prefs.setBool('vegan', filters['vegan'] as bool);
    prefs.setBool('vegetarian', filters['vegetarian'] as bool);
    notifyListeners();
  }

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    filters['gluten'] = prefs.getBool('gluten') ?? false;
    filters['lactose'] = prefs.getBool('lactose') ?? false;
    filters['vegan'] = prefs.getBool('vegan') ?? false;
    filters['vegetarian'] = prefs.getBool('vegetarian') ?? false;
    prefsMealId = prefs.getStringList('prefsMealId') ?? [];
    for (var mealId in prefsMealId) {
      final existingIndex =
          favoriteMeals.indexWhere((meal) => meal.id == mealId);
      if (existingIndex < 0) {
        favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      }
    }
    print(filters['vegetarian'].toString());
    print(filters['lactose'].toString());
    print(filters['gluten'].toString());
    notifyListeners();
  }

  List<Meal> favoriteMeals = [];
  List<String> prefsMealId = [];
  bool isMealFavorite(String mealId) {
    return favoriteMeals.any((meal) => meal.id == mealId);
  }

  void toggleFavorites(String mealId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final existingIndex = favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      favoriteMeals.removeAt(existingIndex);
      prefsMealId.remove(mealId);
    } else {
      favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      prefsMealId.add(mealId);
    }
    // isMealFavorite = favoriteMeals.any((meal) => meal.id == mealId);
    notifyListeners();
    prefs.setStringList('prefsMealId', prefsMealId);
  }
}

bannerCustom(String id, handlerAdLoaded) {
  return BannerAd(
      adUnitId: id,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: handlerAdLoaded,
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
        },
      ));
}
