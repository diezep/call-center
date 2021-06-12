import 'package:call_center/src/core/abstraction/MDuration.dart';
import 'package:call_center/src/core/models/Date.dart';

abstract class CallBase {
  CallBase({String id, MDuration duration, Date date});

  String get id => id;
  MDuration get duration => duration;
  Date get date => date;

  set id(String newValue) => id = newValue;
  set duration(MDuration newValue) => duration = newValue;
  set date(Date newValue) => date = newValue;

  bool operator ==(otherCall);

  String toString();
}
