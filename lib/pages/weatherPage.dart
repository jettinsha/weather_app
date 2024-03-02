import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          //city name
          Text(_weather?.cityName ?? "Loading City..."),
          Text('${_weather?.temperature.round}*C')

          // temperature
        ]),
      ),
    );
  }
}
