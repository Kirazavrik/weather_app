import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/CurrentWeather.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_icons/weather_icons.dart';

void main() => runApp(MyApp());

Future<CurrentWeather> fetchCurrentWeather() async{

  final response =
  await http.get('https://api.openweathermap.org/data/2.5/weather?lat=53.35&lon=24.15&appid=895e937378a75b1c31820b814680ee59&units=metric&lang=ru');

  if (response.statusCode == 200) {
    return CurrentWeather.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed');
  }
}

class MyApp extends StatefulWidget {

  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<CurrentWeather> weather;

  @override
  void initState() {
    super.initState();
    weather = fetchCurrentWeather();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Hello There',
        theme: ThemeData(
          primaryColor: Colors.black,
          fontFamily: 'Quicksand',
          primarySwatch: Colors.amber
        ),
        home: Scaffold(
            appBar: AppBar(
              title: Text('Fetch Data Example'),
            ),
            body: weatherWidget()
        )
    );
  }

  Widget weatherWidget() {
    return Container(
      color: Colors.grey.shade900,
      child: FutureBuilder<CurrentWeather>(
        future: weather,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column (
                children: <Widget>[
                  Text(
                    ('Temperature: ' + snapshot.data.wind.deg.toString()),
                    style: TextStyle(
                      fontSize: 20.0,fontWeight: FontWeight.w700, color: Colors.grey.shade50
                    ),
                  ),
                  Text('Humidity: ' + snapshot.data.wind.deg.toString()),
                  BoxedIcon(WeatherIcons.day_rain_wind, size: 30.0, color: Colors.grey,)
                ],
              crossAxisAlignment: CrossAxisAlignment.center,
            );

          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  Column drawMainScreen(AsyncSnapshot<CurrentWeather> snap) {
    return Column (
      children: <Widget>[
        Text('Temperature: ' + snap.data.main.temp.toString()),
        Text('Humidity: ' + snap.data.main.humidity.toString())
      ]
    );
  }
}
