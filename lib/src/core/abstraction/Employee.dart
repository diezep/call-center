import 'package:call_center/src/core/abstraction/WeekSchedule.dart';

abstract class Employee {
  String id, name;
  WeekSchedule weekSchedule;

  Employee({this.id, this.name, this.weekSchedule});
}
