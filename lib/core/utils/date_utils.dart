import 'package:intl/intl.dart';

String getFormattedDate(DateTime date) {
  return DateFormat('MMM dd').format(date);
}

String getMonth(DateTime date) {
  return DateFormat('MMMM').format(date);
}