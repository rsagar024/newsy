import 'package:intl/intl.dart';

class DateFormatter {
  String formatDate(String date) {
    DateTime dateTime = DateTime.parse(date).toLocal();
    String formattedDate = DateFormat('dd MMM yyyy, hh:mm a').format(dateTime);
    return formattedDate;
  }
}
