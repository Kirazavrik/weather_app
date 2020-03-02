
class DateTimeConverter {
  String date;

  DateTimeConverter({this.date});

  factory DateTimeConverter.getDateTime(String inputDate) {
    Map<int, String> weekdayMap = {
      1: 'Понедельник',
      2: 'Вторник',
      3: 'Среда',
      4: 'Четверг',
      5: 'Пятница',
      6: 'Суббота',
      7: 'Воскресенье'
    };

    Map<int, String> monthMap = {
      1: 'января',
      2: 'февраля',
      3: 'марта',
      4: 'апреля',
      5: 'мая',
      6: 'июня',
      7: 'июля',
      8: 'августа',
      9: 'сентября',
      10: 'октября',
      11: 'ноября',
      12: 'декабря'
    };

    String dayOfWeek;
    String currentMonth;
    var inputDateTime = DateTime.parse(inputDate);
    String day = inputDateTime.day.toString();
    String month = inputDateTime.month.toString();
    String year = inputDateTime.year.toString();

    for (var key in weekdayMap.keys) {
      if (key == inputDateTime.weekday) {
        dayOfWeek = weekdayMap[key];
      }
    }

    for (var key in monthMap.keys) {
      if (key == inputDateTime.month) {
        currentMonth = monthMap[key];
      }
    }

    String outputDateTime = dayOfWeek + ' ' + day + ' ' + currentMonth;

    return DateTimeConverter(
      date: outputDateTime
    );
  }
}