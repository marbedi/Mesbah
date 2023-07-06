import 'package:shamsi_date/shamsi_date.dart';

class DateHelper {
  static List<DateTime> get daysOfMonth {
    int numberOfMonths = 3;
    // List<Jalali> dates = [];

    // DateTime currentDate = DateTime.now();
    // Jalali persianDate = Jalali.fromDateTime(currentDate);
    // Jalali firstDayOfMonth = Jalali(persianDate.year, persianDate.month, 1);
    // Jalali lastDayOfMonth =
    //     Jalali(persianDate.year, persianDate.month, persianDate.monthLength);

    // for (Jalali date = firstDayOfMonth;
    //     date <= lastDayOfMonth;
    //     date = date.addDays(1)) {
    //   dates.add(date);
    // }
    // return dates;
    List<DateTime> dates = [];

    DateTime currentDate = DateTime.now();
    Jalali persianDate = Jalali.fromDateTime(currentDate);

    int startMonthIndex = persianDate.month - numberOfMonths ~/ 2;
    int endMonthIndex = persianDate.month + numberOfMonths ~/ 2;

    for (int i = startMonthIndex; i <= endMonthIndex; i++) {
      Jalali firstDayOfMonth = Jalali(persianDate.year, i, 1);
      Jalali lastDayOfMonth =
          Jalali(persianDate.year, i, Jalali(persianDate.year, i).monthLength);

      for (Jalali date = firstDayOfMonth;
          date <= lastDayOfMonth;
          date = date.addDays(1)) {
        dates.add(date.toDateTime());
      }
    }

    return dates;
  }
}
