import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:meal/providers/meal_provider.dart';
import 'package:meal/screens/categories_scrn.dart';
import 'package:meal/screens/favor_scrn.dart';
import 'package:meal/widgets/main_drawer.dart';

class TabScrn extends StatefulWidget {
  @override
  _TabScrnState createState() => _TabScrnState();
}

class _TabScrnState extends State<TabScrn> {
  int selectPageValue = 0;
  late final List<Map<String, Object>> pages;
  @override
  void initState() {
    Provider.of<MealProvider>(context, listen: false).getData();
    pages = [
      {
        'page': CategoriesScrn(),
        'title': 'Category',
      },
      {
        'page': FavoritesScrn(),
        'title': "Your Favorites",
      }
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pages[selectPageValue]['title'].toString()),
      ),
      body: pages[selectPageValue]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Colors.white,
        currentIndex: selectPageValue,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.category), title: Text("Category")),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), title: Text("Favorite"))
        ],
      ),
      drawer: MainDrawer(),
    );
  }

  void _selectPage(int value) {
    setState(() {
      selectPageValue = value;
    });
  }
}

Widget checkForAd(bool loaded, BannerAd _banner, ctx) {
  if (loaded == true) {
    return Container(
      child: AdWidget(
        ad: _banner,
      ),
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
    );
  } else {
    return Center(
      child: ListTile(
        title: Text(
          'Loading Ad',
          style: TextStyle(color: Colors.green[100], fontSize: 20),
        ),
        trailing: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
        ),
      ),
    );
  }
}
