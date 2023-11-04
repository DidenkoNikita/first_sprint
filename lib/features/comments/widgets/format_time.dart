import 'package:intl/intl.dart';

String formatTime(String dateString) {
  DateTime date = DateTime.parse(dateString);
  DateTime now = DateTime.now();
  Duration difference = now.difference(date);
  String formattedDate = DateFormat('h:mm a').format(date);

  if (difference.inMinutes < 60) {
    return formattedDate;
  } else if (difference.inMinutes < 24 * 60) {
    return 'Yesterday at $formattedDate';
  } else if (difference.inMinutes < 30 * 24 * 60) {
    int daysAgo = difference.inDays;
    return '$daysAgo days ago at $formattedDate';
  } else if (difference.inMinutes < 12 * 30 * 24 * 60) {
    int monthsAgo = (difference.inDays / 30).floor();
    return '$monthsAgo months ago at $formattedDate';
  } else {
    int yearsAgo = (difference.inDays / (365.25)).floor();
    return '$yearsAgo years ago at $formattedDate';
  }
}
