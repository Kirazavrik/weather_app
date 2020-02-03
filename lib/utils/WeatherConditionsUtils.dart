class WeatherConditionsUtils {
  String currentCondition;

  WeatherConditionsUtils({this.currentCondition});

  factory WeatherConditionsUtils.getCondition(int conditionCode) {
    String iconCode;
    Map<int, String> daytimeConditions = {
      200: 'wi-day-thunderstorm',
      201: 'wi-day-thunderstorm',
      202: 'wi-day-thunderstorm',
      210: 'wi-day-lightning',
      211: 'wi-day-lightning',
      212: 'wi-day-lightning',
      221: 'wi-day-lightning',
      230: 'wi-day-storm-showers',
      231: 'wi-day-storm-showers',
      232: 'wi-day-storm-showers',
      300: 'wi-day-sprinkle',
      301: 'wi-day-sprinkle',
      302: 'wi-day-sprinkle',
      310: 'wi-day-sprinkle',
      311: 'wi-day-sprinkle',
      312: 'wi-day-sprinkle',
      313: 'wi-day-sprinkle',
      314: 'wi-day-sprinkle',
      321: 'wi-day-sprinkle',
      501: 'wi-day-rain-mix',
      500: 'wi-day-rain-mix',
      502: 'wi-day-rain',
      503: 'wi-day-rain',
      504: 'wi-day-rain',
      511: 'wi-day-sleet',
      520: 'wi-day-hail',
      521: 'wi-day-hail',
      522: 'wi-day-hail',
      531: 'wi-day-hail',
      601: 'wi-day-snow',
      600: 'wi-day-snow',
      602: 'wi-day-snow',
      611: 'wi-day-sleet',
      612: 'wi-day-sleet',
      613: 'wi-day-sleet',
      614: 'wi-day-sleet',
      615: 'wi-day-sleet',
      616: 'wi-day-sleet',
      620: 'wi-day-snow',
      621: 'wi-day-snow',
      622: 'wi-day-snow',
      701: 'wi-fog',
      711: 'wi-smoke',
      721: 'wi-day-haze',
      731: 'wi-dust',
      741: 'wi-fog',
      751: 'wi-sandstorm',
      761: 'wi-dust',
      762: 'wi-dust',
      771: 'wi-strong-wind',
      781: 'wi-tornado',
      800: 'wi-day-sunny',
      801: 'wi-day-cloudy',
      802: 'wi-day-cloudy',
      803: 'wi-day-cloudy',
      804: 'wi-day-cloudy-high'
    };
    for (var key in daytimeConditions.keys) {
      if (key == conditionCode) {
        iconCode = daytimeConditions[key];
      }
    }

    return WeatherConditionsUtils(
      currentCondition: iconCode
    );
  }
}