import 'package:call_center/src/core/abstraction/MDuration.dart';
import 'package:call_center/src/core/models/Date.dart';

abstract class CallBase {
  CallBase({this.id, this.duration, this.date});

  String id;
  MDuration duration;
  Date date;

  bool operator ==(otherCall);

  String toString();
  @override
  int get hashCode => super.hashCode;
}
