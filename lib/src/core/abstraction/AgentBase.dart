import 'package:call_center/src/core/abstraction/WeekSchedule.dart';
import 'package:call_center/src/core/abstraction/employee.dart';
import 'package:call_center/src/core/enum/AgentSpecialty.dart';
import 'package:call_center/src/core/models/Client.dart';
import 'package:call_center/src/core/structures/MSimpleList.dart';

abstract class AgentBase extends Employee {
  String extensionNumber;
  int extraWeeekHours;
  MSimpleList<Client> clients;
  AgentSpeciality speciality;
  String image;

  AgentBase({
    String name,
    String id,
    this.extensionNumber,
    this.image,
    this.extraWeeekHours,
    this.clients,
    this.speciality,
  }) : super(
          name: name,
          id: id,
        );

  String toString();
}
