import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import './map_screen.dart';

// import '../../Helper/location_helper.dart';

class LocationInput extends StatefulWidget {
  final Function selectPlace;

  LocationInput(this.selectPlace);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  // String _previewImgURL;
  bool _isLocated = false;
  double _latitude;
  double _longitude;
  bool _isFetchingLocation = false;

  Future<void> _getCurLocation() async {
    setState(() {
      _isFetchingLocation = true;
      _isLocated = true;
    });
    final locData = await Location().getLocation();
    // final staticImgURL = LocationHelper.generateLocationPreview(
    //   latitude: locData.latitude,
    //   longitude: locData.longitude,
    // );
    // final address = LocationHelper.getPlaceAddress(
    //   locData.latitude,
    //   locData.longitude,
    // );
    setState(() {
      // _previewImgURL = staticImgURL;
      _latitude = locData.latitude;
      _longitude = locData.longitude;
      _isFetchingLocation = false;
    });
    widget.selectPlace(_latitude, _longitude);
  }

  Future<void> _selectOnMap() async {
    final locData = await Location().getLocation();
    final LatLng selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => MapScreen(
          latitude: locData.latitude,
          longitude: locData.longitude,
          isSelecting: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 170,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          alignment: Alignment.center,
          child: !_isLocated
              ? Text(
                  "No location chosen",
                  textAlign: TextAlign.center,
                )
              : _isFetchingLocation
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Latitude - $_latitude",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Longitude - $_longitude",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.location_on),
              label: Text("Get Location"),
              textColor: Theme.of(context).primaryColor,
              onPressed: _getCurLocation,
            ),
            // FlatButton.icon(
            //   icon: Icon(Icons.map),
            //   label: Text("Select on map"),
            //   textColor: Theme.of(context).primaryColor,
            //   onPressed: _selectOnMap,
            // ),
          ],
        ),
      ],
    );
  }
}
