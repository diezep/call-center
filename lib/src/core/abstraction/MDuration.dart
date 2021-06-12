class MDuration {
  int hours;
  int minutes;
  MDuration({this.hours, this.minutes});

  @override
  String toString() => "$hours:$minutes";

  static MDuration fromString(String durationStr) {
    return MDuration(
        hours: durationStr.split(":")[0] as int,
        minutes: durationStr.split(":")[1] as int);
  }

  Map<String, dynamic> toMap() => {
        "hours": hours,
        "minutes": minutes,
      };

  static MDuration fromMap(Map<String, dynamic> map) => MDuration(
        hours: map["hours"],
        minutes: map["minutes"],
      );
}

class MDurationException implements Exception {
  String message;

  MDurationException(this.message);

  @override
  String toString() => message;
}
