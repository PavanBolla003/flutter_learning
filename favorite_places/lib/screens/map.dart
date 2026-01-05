import 'package:favorite_places/models/place.dart';
import 'package:flutter/material.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  PlaceLocation? _pickedLocation;

  void _selectLocation() {
    // For simplicity, return a dummy location
    _pickedLocation = const PlaceLocation(
      latitude: 37.422,
      longitude: -122.084,
      address: 'Mountain View, CA',
    );
    Navigator.of(context).pop(_pickedLocation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick Location'),
        actions: [
          IconButton(
            onPressed: _selectLocation,
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: const Center(
        child: Text('Map would be here. Tap check to select dummy location.'),
      ),
    );
  }
}