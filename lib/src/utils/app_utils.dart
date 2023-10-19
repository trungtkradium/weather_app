import 'package:intl/intl.dart';

class AppUtils {
  static String fromCelsiusToFahrenheit(double celsius) {
    return ((celsius * 9 / 5) + 32.0).toStringAsFixed(2);
  }

  static String getDegreeSymbol(bool isCelsiusDegree) {
    return isCelsiusDegree ? '\u2103' : '\u2109';
  }

  static String formatYMEd(DateTime dateTime) {
    return DateFormat.yMEd('en_US').add_jms().format(dateTime);
  }
}
