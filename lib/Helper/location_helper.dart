import 'dart:convert';

import 'package:http/http.dart' as http;

const GOOGLE_API_KEY = "AIzaSyBIq2dakA7F-iiNOzfgQK81UQCWPJejS8A";
const ADDRESS_API_KEY = "61b6dc93937ee08d1072be4b00f5fa3b";

class LocationHelper {
  static String generateLocationPreview({
    double latitude,
    double longitude,
  }) {
    return "https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C$latitude,$longitude&key=$GOOGLE_API_KEY";
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {
    final url = Uri.parse("http://api.positionstack.com/v1/forward?access_key=$ADDRESS_API_KEY&query=$lat,$lng");
    final response = await http.get(url);
    final result = json.decode(response.body)['results'];
    return result;
  }
}
