import 'package:favorite_places/widgets/places_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_places.dart';
import 'add_place.dart';

class PlacesScreen extends StatefulWidget {
  const PlacesScreen({super.key});

  @override
  State<PlacesScreen> createState() => _PlacesScreenState();
}

class _PlacesScreenState extends State<PlacesScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<UserPlaces>(context, listen: false).loadPlaces();
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => const AddPlaceScreen()),
              );
            },
          ),
        ],
      ),
      body: Consumer<UserPlaces>(
        builder: (ctx, userPlaces, child) =>
            PlacesList(places: userPlaces.places),
      ),
    );
  }
}
