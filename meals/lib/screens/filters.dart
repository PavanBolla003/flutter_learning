import 'package:flutter/material.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;

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
        ],
      ),
    );
  }
}
