import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/ForecastFiveDays.dart';
import 'models/CurrentWeather.dart';
import 'package:weather_icons/weather_icons.dart';
import 'utils/WeatherConditionsUtils.dart';

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

Future<ForecastFiveDays> fetchForecastFiveDays() async{

  final response =
  await http.get('https://api.openweathermap.org/data/2.5/forecast?lat=53.35&lon=24.15&appid=895e937378a75b1c31820b814680ee59&units=metric&lang=ru');

  if (response.statusCode == 200) {
    return ForecastFiveDays.fromJson(json.decode(response.body));
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
  int humidity;
  double temp;
  double feelsLike;
  List<Weather> weatherArray;
  String description;
  int conditionCode;
  String iconCode;
  Future<CurrentWeather> currentWeather;
  Future<ForecastFiveDays> forecastFiveDays;

  @override
  void initState() {
    super.initState();
    currentWeather = fetchCurrentWeather();
    forecastFiveDays = fetchForecastFiveDays();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Hello There',
        theme: ThemeData(
          primaryColor: Colors.grey.shade900,
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
      color: Colors.white,
      child: FutureBuilder<CurrentWeather>(
        future: currentWeather,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            temp = snapshot.data.main.temp;
            weatherArray = snapshot.data.weather;
            description = weatherArray[0].description;
            feelsLike = snapshot.data.main.feelsLike;
            humidity = snapshot.data.main.humidity;
            conditionCode = weatherArray[0].weatherId;
            iconCode = WeatherConditionsUtils.getCondition(conditionCode).currentCondition;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column (
                  children: <Widget>[
                    weatherWidget1(temp, description, iconCode),
                    weatherWidget2(feelsLike, humidity),
                    new Divider(color: Colors.black,),
                    Expanded(child: forecastFiveDaysWidget())
                  ],
              ),
            );

          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  Widget weatherWidget1(double tempus, String descript, String curentIconCode) => Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          (tempus.toInt().toString() + "\u00B0"),
          style: TextStyle(
              fontSize: 120.0, color: Colors.grey, fontWeight: FontWeight.w100
          ),
        ),
        Column(
          children: <Widget>[
            BoxedIcon(
              WeatherIcons.fromString(curentIconCode, fallback: WeatherIcons.na),
              size: 50.0, color: Colors.grey,),
            Text(
              descript,
              style: TextStyle(fontSize: 18.0, color: Colors.grey, fontFamily: 'CyrilicRound'),
            )
          ],
        )
      ],
    ),
  );

  Widget weatherWidget2(double feels, int humidity) => Container(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                'ощущается как ',
                style: TextStyle(fontSize: 18.0, color: Colors.grey, fontFamily: 'CyrilicRound' ),
              ),
              Text(
                feels.toInt().toString(),
                style: TextStyle(fontSize: 18.0, color: Colors.grey, fontFamily: 'CyrilicRound' ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              BoxedIcon(WeatherIcons.humidity, color: Colors.grey,),
              Text(
                humidity.toString() + '%',
                style: TextStyle(fontSize: 18.0, color: Colors.grey, fontFamily: 'CyrilicRound' ),
              ),
            ],
          )
        ],
      ),
    ),
  );

  Widget forecastFiveDaysWidget() => Container(
    child: FutureBuilder<ForecastFiveDays>(
      future: forecastFiveDays,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<ThreeHourWeather> weathersArray = snapshot.data.listOfWeather;
          getFiveDaysForecast(weathersArray);
          return ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 50.0,
                  child: Center(child: Text(DateTime.now().day.toString())),
                );
              },
              separatorBuilder: (BuildContext context, int index) => const Divider()
          );
        } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
        }
        return CircularProgressIndicator();
      },
    ),
  );
  
  getFiveDaysForecast(List<ThreeHourWeather> list) {
    int currentDate = DateTime.now().day;
    var listWithoutCurrentDay = list.where((item) => int.parse(item.datetime.substring(8, 10)) > currentDate).toList();
    print(listWithoutCurrentDay[0].datetime);
  }

}
