abstract class MDuration {
  int hours;
  int seconds;
  MDuration({this.hours, this.seconds});
}

class MDurationException {
  String message;

  MDurationException(this.message);

  @override
  String toString() => message;
}
