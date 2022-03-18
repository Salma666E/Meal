import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:meal/providers/meal_provider.dart';
import 'package:meal/widgets/main_drawer.dart';
import 'package:provider/provider.dart';

import '../ad_helper.dart';
import 'tabs_scrn.dart';

class FiltersScrn extends StatefulWidget {
  static const String routName = "/filters";
  @override
  _FiltersScrnState createState() => _FiltersScrnState();
}

class _FiltersScrnState extends State<FiltersScrn> {
  Widget buildSwitchListTile(oldVal, title, subtitle, upDateValue) {
    return SwitchListTile(
        value: oldVal,
        title: Text(title),
        subtitle: Text(subtitle),
        onChanged: upDateValue);
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, bool> _filters =
        Provider.of<MealProvider>(context, listen: true).filters;
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         Map<String, bool> _slectedfilters = {
        //           'gluten': _filters['gluten'] as bool,
        //           'lactose': _filters['lactose'] as bool,
        //           'vegan': _filters["vegan"] as bool,
        //           'vegetarian': _filters['vegetarian'] as bool
        //         };
        //         Provider.of<MealProvider>(context, listen: false)
        //             .setFilters(_slectedfilters);
        //         Navigator.of(context).pushReplacementNamed('/');
        //       },
        //       icon: Icon(Icons.save))
        // ],
      ),
      drawer: MainDrawer(),
      body: SafeArea(
          child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15.0),
            child: Text(
              'Adjust your meal selection.',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              buildSwitchListTile(_filters['gluten'], 'Gluten-Free',
                  'Only include gluten-free meals', (newVal) {
                setState(() {
                  _filters['gluten'] = newVal;
                });
                Provider.of<MealProvider>(context, listen: false).setFilters();
              }),
              buildSwitchListTile(
                  _filters["vegan"], 'Vegan', 'Only include vegan meals',
                  (newVal) {
                setState(() {
                  _filters["vegan"] = newVal;
                });
                Provider.of<MealProvider>(context, listen: false).setFilters();
              }),
              buildSwitchListTile(_filters['vegetarian'], 'Vegetarian',
                  'Only include vegetarian meals', (newVal) {
                setState(() {
                  _filters['vegetarian'] = newVal;
                });
                Provider.of<MealProvider>(context, listen: false).setFilters();
              }),
              buildSwitchListTile(_filters['lactose'], 'Lactose-Free',
                  'Only include lactose-free meals', (newVal) {
                setState(() {
                  _filters['lactose'] = newVal;
                });
                Provider.of<MealProvider>(context, listen: false).setFilters();
              }),
            ],
          )),
          Container(
            height: 55.0,
            color: Colors.grey[900],
            child: checkForAd(
                Provider.of<MealProvider>(context, listen: true).isLoaded1,
                Provider.of<MealProvider>(context, listen: true).bannerAd1,
                context),
          )
        ],
      )),
    );
  }
}
