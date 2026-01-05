import 'dart:io';
import 'package:flutter/material.dart';
import '../models/place.dart';
import '../data/places_database.dart';

class UserPlaces with ChangeNotifier {
  List<Place> _places = [];

  List<Place> get places => [..._places];

  Future<void> loadPlaces() async {
    _places = await PlacesDatabase.getPlaces();
    notifyListeners();
  }

  void addPlace(String title, File image, PlaceLocation location) {
    final newPlace = Place(title: title, image: image, location: location);
    _places.add(newPlace);
    PlacesDatabase.insertPlace(newPlace);
    notifyListeners();
  }
}
