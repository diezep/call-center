import 'package:call_center/src/core/abstraction/MDuration.dart';
import 'package:call_center/src/core/models/Date.dart';

abstract class CallBase {
  String id;
  MDuration duration;
  Date date;
  CallBase({this.id, this.duration, this.date});

  bool operator ==(otherDate);

  String toString();
}
