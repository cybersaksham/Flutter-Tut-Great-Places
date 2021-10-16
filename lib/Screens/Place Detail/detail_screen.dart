import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Provider/great_places.dart';

class PlaceDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final placeId = ModalRoute.of(context).settings.arguments as String;
    final place = Provider.of<GreatPlaces>(
      context,
      listen: false,
    ).findByID(placeId);

    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 300,
            width: double.infinity,
            child: Image.file(
              place.image,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              place.location.address,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
