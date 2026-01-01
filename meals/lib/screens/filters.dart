import 'package:flutter/material.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({
    super.key,
    required this.glutenFree,
    required this.lactoseFree,
    required this.vegetarian,
    required this.vegan,
    required this.onGlutenFreeChanged,
    required this.onLactoseFreeChanged,
    required this.onVegetarianChanged,
    required this.onVeganChanged,
  });

  final bool glutenFree;
  final bool lactoseFree;
  final bool vegetarian;
  final bool vegan;
  final ValueChanged<bool> onGlutenFreeChanged;
  final ValueChanged<bool> onLactoseFreeChanged;
  final ValueChanged<bool> onVegetarianChanged;
  final ValueChanged<bool> onVeganChanged;

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Filters')),
      body: Column(
        children: [
          SwitchListTile(
            value: widget.glutenFree,
            onChanged: widget.onGlutenFreeChanged,
            title: const Text('Gluten-Free'),
            subtitle: const Text('Only include gluten-free meals.'),
          ),
          SwitchListTile(
            value: widget.lactoseFree,
            onChanged: widget.onLactoseFreeChanged,
            title: const Text('Lactose-Free'),
            subtitle: const Text('Only include lactose-free meals.'),
          ),
          SwitchListTile(
            value: widget.vegetarian,
            onChanged: widget.onVegetarianChanged,
            title: const Text('Vegetarian'),
            subtitle: const Text('Only include vegetarian meals.'),
          ),
          SwitchListTile(
            value: widget.vegan,
            onChanged: widget.onVeganChanged,
            title: const Text('Vegan'),
            subtitle: const Text('Only include vegan meals.'),
          ),
        ],
      ),
    );
  }
}
