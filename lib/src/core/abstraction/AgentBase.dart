import 'package:call_center/src/core/abstraction/WeekSchedule.dart';
import 'package:call_center/src/core/abstraction/employee.dart';
import 'package:call_center/src/core/enum/AgentSpecialty.dart';
import 'package:call_center/src/core/models/client.dart';
import 'package:call_center/src/core/abstraction/MList.dart';

abstract class AgentBase extends Employee {
  int extensionNumber;
  int extraWeeekHours;
  MList<Client> clients;
  AgentSpeciality speciality;
  AgentBase({
    String name,
    String id,
    WeekSchedule weekSchedule,
    this.extensionNumber,
    this.extraWeeekHours,
    this.clients,
    this.speciality,
  }) : super(
          name: name,
          id: id,
          weekSchedule: weekSchedule,
        );

  String toString();
}
