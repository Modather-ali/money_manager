import 'package:get/get.dart';

class DateFormatter {
  static final Map<int, String> weekDayFull = {
    1: 'Monday',
    2: 'Tuesday',
    3: 'Wednesday',
    4: 'Thursday',
    5: 'Friday',
    6: 'Saturday',
    7: 'Sunday'
  };

  static Map<int, String> monthsAR = {
    1: "يناير",
    2: "فبراير",
    3: "مارس",
    4: "أبريل",
    5: "مايو",
    6: "يونيو",
    7: "يوليو",
    8: "أغسطس",
    9: "سبتمبر",
    10: "أكتوبر",
    11: "نوفمبر",
    12: "ديسمبر",
  };
  static Map<int, String> monthsEn = {
    1: 'January',
    2: 'February',
    3: 'March',
    4: 'April',
    5: 'May',
    6: 'June',
    7: 'July',
    8: 'August',
    9: 'September',
    10: 'October',
    11: 'November',
    12: 'December',
  };

  static String formatDateEN(DateTime dateTime, {bool isFull = true}) {
    if (isFull) {
      return ' ${dateTime.hour}:${dateTime.minute}, ${dateTime.day} ${monthsEn[dateTime.month]!.tr}, ${dateTime.year}';
    }
    return '${dateTime.day} ${monthsEn[dateTime.month]!.tr}, ${dateTime.year}';
  }

  static String formatDateAR(DateTime dateTime, {bool isFull = true}) {
    if (isFull) {
      return ' ${dateTime.hour}:${dateTime.minute}, ${dateTime.day} ${monthsAR[dateTime.month]!.tr}, ${dateTime.year}';
    }
    return '${dateTime.day} ${monthsAR[dateTime.month]!.tr}, ${dateTime.year}';
  }
}
