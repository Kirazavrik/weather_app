
class ForecastFiveDays {
  final int count;
  final List<ThreeHourWeather> listOfWeather;

  ForecastFiveDays({this.count, this.listOfWeather});

  factory ForecastFiveDays.fromJson(Map<String, dynamic> json) {
    var list = json['list'] as List;
    print(list.runtimeType);
    List<ThreeHourWeather> weatherList = list.map((i) => ThreeHourWeather.fromJson(i)).toList();

    return ForecastFiveDays(
      count: json['cnt'] as int,
      listOfWeather: weatherList
    );
  }
}

class ThreeHourWeather {
  final String datetime;
  Main main;
  final List<ForecastWeathers> forecastWeathers;

  ThreeHourWeather({this.datetime, this.main, this.forecastWeathers});

  factory ThreeHourWeather.fromJson(Map<String, dynamic> json) {
    var list = json['weather'] as List;
    print(list.runtimeType);
    List<ForecastWeathers> forecastWeathersList = list.map((i) => ForecastWeathers.fromJson(i)).toList();
    return ThreeHourWeather(
      datetime: json['dt_txt'] as String,
      main: Main.fromJson(json['main']),
      forecastWeathers: forecastWeathersList
    );
  }
}

class Main {
  var temperature;

  Main({this.temperature});

  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
      temperature: json['temp']
    );
  }
}

class ForecastWeathers {
  int id;

  ForecastWeathers({this.id});

  factory ForecastWeathers.fromJson(Map<String, dynamic> json) {
    return ForecastWeathers(
        id: json['id'] as int
    );
  }
}
