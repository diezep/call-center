import 'package:call_center/src/core/abstraction/MDuration.dart';
import 'package:call_center/src/core/models/Date.dart';

abstract class CallBase {
  CallBase({String id, MDuration duration, Date date});

  String get id;
  MDuration get duration;
  Date get date;

  set id(String newValue);
  set duration(MDuration newValue);
  set date(Date newValue);

  bool operator ==(otherCall);

  String toString();
  @override
  int get hashCode => super.hashCode;
}
