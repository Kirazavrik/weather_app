import 'dart:convert';

import 'package:weather_app/models/WeatherBase.dart';

class CurrentWeather {
  final int id;
  final Main main;
  final Wind wind;
  final List<Weather> weather;

  CurrentWeather({this.id, this.main, this.wind, this.weather});

  @override
  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    var list = json['weather'] as List;
    List<Weather> weatherList = list.map((i) => Weather.fromJson(i)).toList();

    return CurrentWeather(
        id: json['id'] as int,
        main: Main.fromJson(json['main']),
        wind: Wind.fromJson(json['wind']),
        weather: weatherList
    );
  }
}

class Weather {
  final String description;
  final int weatherId;

  Weather({this.description, this.weatherId});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      description: json['description'] as String,
      weatherId: json['id'] as int
    );
  }
}

class Wind {
  var deg;
  final speed;

  Wind({this.deg, this.speed});

  factory Wind.fromJson(Map<String, dynamic> json) {

    return Wind (
        deg: json['deg'],
        speed: json['speed']
    );
  }
}

class Main {
  int humidity;
  double temp;
  double feelsLike;

  Main({this.humidity, this.temp, this.feelsLike});

  factory Main.fromJson(Map<String, dynamic> json) {

    return Main (
        humidity: json['humidity'] as int,
        temp: json['temp'],
        feelsLike: json['feels_like'] as double
    );

  }
}