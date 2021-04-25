import 'package:call_center/src/core/abstraction/DateBase.dart';

class Date extends DateBase {
  int month;
  int year;
  int day;
  int hour;
  int seconds;

  Date({this.month, this.year, this.day, this.hour = 0, this.seconds = 0}) {
    if (day < 1 || day > 31) throw DateException("Invalid day.");
    if (hour < 0 || hour > 24) throw DateException("Invalid hour.");
    if (seconds < 0 || seconds > 59) throw DateException("Invalid seconds.");
    if (month < 0 || month > 12) throw DateException("Invalid month.");
  }

  @override
  bool operator <(otherDate) {
    // TODO: implement <
    throw UnimplementedError();
  }

  @override
  bool operator <=(otherDate) {
    // TODO: implement <=
    throw UnimplementedError();
  }

  @override
  bool operator >(otherDate) {
    // TODO: implement >
    throw UnimplementedError();
  }

  @override
  bool operator >=(otherDate) {
    // TODO: implement >=
    throw UnimplementedError();
  }

  @override
  bool isValid() {
    // TODO: implement isValid
    throw UnimplementedError();
  }

  @override
  // TODO: implement timeSinceEponch
  int get timeSinceEponch => throw UnimplementedError();
}

class DateException {
  String message;
  DateException(this.message);
}
