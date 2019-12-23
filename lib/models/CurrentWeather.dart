

class CurrentWeather {
  final int id;
  Main main;
  Wind wind;

  CurrentWeather({this.id, this.main, this.wind});

  factory CurrentWeather.fromJson(Map<String, dynamic> parsedJson) {
    return CurrentWeather(
        id: parsedJson['id'],
        main: Main.fromJson(parsedJson['main']),
        wind: Wind.fromJson(parsedJson['wind'])
    );
  }
}

class Wind {
  int deg;
  int speed;

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

  Main({this.humidity, this.temp});

  factory Main.fromJson(Map<String, dynamic> json) {
    return Main (
        humidity: json['humidity'],
        temp: json['temp']
    );
  }
}