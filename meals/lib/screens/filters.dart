import 'package:flutter/material.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _lactoseFree = false;
  bool _vegetarian = false;
  bool _vegan = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Filters')),
      body: Column(
        children: [
          SwitchListTile(
            value: _glutenFree,
            onChanged: (isChecked) {
              setState(() {
                _glutenFree = isChecked;
              });
            },
            title: const Text('Gluten-Free'),
            subtitle: const Text('Only include gluten-free meals.'),
          ),
          SwitchListTile(
            value: _lactoseFree,
            onChanged: (isChecked) {
              setState(() {
                _lactoseFree = isChecked;
              });
            },
            title: const Text('Lactose-Free'),
            subtitle: const Text('Only include lactose-free meals.'),
          ),
          SwitchListTile(
            value: _vegetarian,
            onChanged: (isChecked) {
              setState(() {
                _vegetarian = isChecked;
              });
            },
            title: const Text('Vegetarian'),
            subtitle: const Text('Only include vegetarian meals.'),
          ),
          SwitchListTile(
            value: _vegan,
            onChanged: (isChecked) {
              setState(() {
                _vegan = isChecked;
              });
            },
            title: const Text('Vegan'),
            subtitle: const Text('Only include vegan meals.'),
          ),
        ],
      ),
    );
  }
}
