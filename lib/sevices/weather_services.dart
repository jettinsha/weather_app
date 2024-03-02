import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/models/weather_models.dart';
import 'package:http/http.dart' as http;

class WeatherServices {
  static const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey;
  WeatherServices(this.apiKey);
  Future<Weather> getWeather(String cityName) async {
    final response = await http
        .get(Uri.parse(('$BASE_URL?q=$cityName&appid=$apiKey&units=metric')));
    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Weather data');
    }
  }

  Future<String> getCurrentCity() async {
    //get permission from user

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    //fetch the current locaton
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    //covert the location into a placemark objects
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    //extract the city name form the first placemark
    String? city = placemarks[0].locality;
    return city ?? "";
  }
}
