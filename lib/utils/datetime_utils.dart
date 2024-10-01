import 'package:intl/intl.dart';

class DateTimeUtils {
  static String getMessageTime(DateTime time) {
    return DateFormat.jm().format(time); // 10:00 AM.
  }
}
