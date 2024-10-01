import 'package:intl/intl.dart';

class DateTimeUtils {
  static String getMessageTime(DateTime time) {
    return DateFormat.jm().format(time); // 10:00 AM.
  }

  static String getLastSeen(DateTime time) {
    final now = DateTime.now();
    final diff = now.difference(time);
    if (diff.inSeconds < 20) {
      return "Online";
    }
    if (diff.inSeconds < 60) {
      return "Last seen less than a minute ago";
    }
    if (diff.inMinutes < 60) {
      return "Last seen ${diff.inMinutes} minutes ago";
    }
    if (diff.inHours < 24) {
      return "Last seen ${diff.inHours} hours ago";
    }
    if (diff.inDays < 30) {
      return "Last seen ${diff.inDays} days ago";
    }
    if (diff.inDays < 365) {
      return "Last seen ${diff.inDays ~/ 30} months ago";
    }
    return "Last seen ${diff.inDays ~/ 365} years ago";
  }
}
