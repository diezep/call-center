class MDuration {
  int hours;
  int seconds;
  MDuration({this.hours, this.seconds});

  @override
  String toString() => "$hours:$seconds";

  static MDuration fromString(String durationStr) {
    return MDuration(
        hours: durationStr.split(":")[0] as int,
        seconds: durationStr.split(":")[1] as int);
  }
}

class MDurationException {
  String message;

  MDurationException(this.message);

  @override
  String toString() => message;
}
