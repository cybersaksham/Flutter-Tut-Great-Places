import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './image_input.dart';
import './location_input.dart';

import '../../Models/place.dart';

import '../../Provider/great_places.dart';

class AddPlaceScreen extends StatefulWidget {
  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleCotroller = TextEditingController();
  final _addressController = TextEditingController();
  File _pickedImg;
  PlaceLocation _pickedLocation;

  void _selectImage(File pickedImg) {
    _pickedImg = pickedImg;
  }

  void _selectPlace(
    double lat,
    double lng,
  ) {
    _pickedLocation = PlaceLocation(
      latitude: lat,
      longitude: lng,
      address: _addressController.text,
    );
  }

  void _savePlace() {
    if (_titleCotroller.text.isEmpty ||
        _addressController.text.isEmpty ||
        _pickedImg == null ||
        _pickedLocation == null) {
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false).addPlace(
      _titleCotroller.text,
      _pickedImg,
      _pickedLocation,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a new place"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(labelText: "Title"),
                      controller: _titleCotroller,
                      textInputAction: TextInputAction.next,
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: "Address"),
                      maxLines: 3,
                      keyboardType: TextInputType.streetAddress,
                      textInputAction: TextInputAction.newline,
                      controller: _addressController,
                    ),
                    SizedBox(height: 20),
                    ImageInput(_selectImage),
                    SizedBox(height: 20),
                    LocationInput(_selectPlace),
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            icon: Icon(Icons.add),
            label: Text("Add Place"),
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Theme.of(context).accentColor,
            onPressed: _savePlace,
          ),
        ],
      ),
    );
  }
}
