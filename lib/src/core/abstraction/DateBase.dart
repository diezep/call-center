abstract class DateBase {
  int month;
  int year;
  int day;
  int hour;
  int seconds;

  DateBase({this.month, this.year, this.day, this.hour = 0, this.seconds = 0});

  int get timeSinceEponch;

  bool operator ==(otherDate);
  bool operator <(otherDate);
  bool operator >(otherDate);
  bool operator <=(otherDate);
  bool operator >=(otherDate);


  String toString();
  bool isValid();

}

class DateException {
  String message;
  DateException(this.message);
}
