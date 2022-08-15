import 'package:intl/intl.dart';

extension ExtensionDouble on DateTime {
  // Sunrise or sunset
  bool isSunsetOrSunrise() {
    String date = DateFormat("HH:mm a").format(this);
    if (date.contains("AM")) {
      // return "Moon: $date";
      return false;
    } else {
      // return "Sun: $date";
      return true;
    }
  }

  String toTime() {
    String date = DateFormat("HH:mm a").format(this);
    return date;
  }
}
