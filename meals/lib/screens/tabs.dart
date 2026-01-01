import 'package:flutter/material.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/models/meal.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favouriteMeals = [];

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _toggleMealFavouriteStatus(Meal meal) {
    final isExisting = _favouriteMeals.contains(meal);
    if (isExisting) {
      setState(() {
        _favouriteMeals.remove(meal);
      });
    } else {
      setState(() {
        _favouriteMeals.add(meal);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoryScreen(
      onToggleFavourite: _toggleMealFavouriteStatus,
    );
    var activePageTitle = 'Meals';

    if (_selectedPageIndex == 1) {
      activePage = const FiltersScreen();
      activePageTitle = 'Filters';
    }

    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle)),
      body: activePage,
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.restaurant),
              title: const Text('Meals'),
              onTap: () {
                setState(() {
                  _selectedPageIndex = 0;
                });
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.filter_list),
              title: const Text('Filters'),
              onTap: () {
                setState(() {
                  _selectedPageIndex = 1;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
