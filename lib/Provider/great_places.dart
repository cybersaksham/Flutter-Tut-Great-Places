import 'dart:io';

import 'package:flutter/material.dart';

import '../Models/place.dart';

import '../Helper/db_helper.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Place findByID(String id) {
    return _items.firstWhere((item) => item.id == id);
  }

  void addPlace(
    String title,
    File image,
    PlaceLocation location,
  ) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      image: image,
      location: location,
      title: title,
    );
    _items.add(newPlace);
    notifyListeners();

    DBHelper.insert(
      'user_places',
      {
        'id': newPlace.id,
        'title': newPlace.title,
        'image': newPlace.image.path,
        'lat': newPlace.location.latitude,
        'lng': newPlace.location.longitude,
        'address': newPlace.location.address,
      },
    );
  }

  Future<void> fetchPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map((item) => Place(
              id: item['id'],
              title: item['title'],
              image: File(item['image']),
              location: PlaceLocation(
                latitude: item['lat'],
                longitude: item['lng'],
                address: item['address'],
              ),
            ))
        .toList();
    notifyListeners();
  }
}
