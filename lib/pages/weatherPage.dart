import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_models.dart';
import 'package:weather_app/sevices/weather_services.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  //api key
  final _WeatherService = WeatherServices('11ac38f213376fba471c0286657ee620');
  Weather? _weather;

//fetch weather
  _fetchWeather() async {
    //get the  current city
    String cityName = await _WeatherService.getCurrentCity();

    // get weather for city
    try {
      final weather = await _WeatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }
// any errors

    catch (e) {
      print(e);
    }
  }

//init state
  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }
// fets=ch weather on startup

//weather animations
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json'; //deffault to sunny
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'fog':
        return 'assets/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          //city name
          Text(_weather?.cityName ?? "Loading City..."),
          //animation
          Lottie.asset('assets/cloud.json'),
          Text('${_weather?.temperature.round}*C'),

          // weather condition

          Text((_weather?.mainCondition ?? ""))

          // temperature
        ]),
      ),
    );
  }
}
