extension DatetimeExtension on DateTime {
  String get toHM {
    return "$hour:$minute";
  }

  String get toTime {
    return "$hour:$minute:$second";
  }

  String get toDate {
    return "$year-$month-$day";
  }

  String get toDateTime {
    return "$year-$month-$day $hour:$minute:$second";
  }
}
