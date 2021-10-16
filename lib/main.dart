import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './Screens/Places List/places_list_screen.dart';
import './Screens/Add Places/add_places_screen.dart';
import './Screens/Place Detail/detail_screen.dart';

import './Models/routes.dart';

import './Provider/great_places.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => GreatPlaces(),
      child: MaterialApp(
        title: "Great Places",
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
        ),
        home: PlacesListScreen(),
        routes: {
          Routes.places_list: (ctx) => PlacesListScreen(),
          Routes.add_places: (ctx) => AddPlaceScreen(),
          Routes.place_detail: (ctx) => PlaceDetail(),
        },
      ),
    );
  }
}
