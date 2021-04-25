import 'package:call_center/src/core/abstraction/AgentBase.dart';
import 'package:call_center/src/core/abstraction/WeekSchedule.dart';
import 'package:call_center/src/core/enum/AgentSpecialty.dart';
import 'package:call_center/src/core/models/client.dart';
import 'package:call_center/src/core/abstraction/MList.dart';

class Agent extends AgentBase {
  Agent({
    MList<Client> clients,
    String name = 'Diego Zepeda',
    String id,
    WeekSchedule weekSchedule,
    int extensionNumber,
    int extraWeeekHours,
    AgentSpeciality speciality = AgentSpeciality.NoSelected,
  }) : super(
            name: name,
            id: id,
            extensionNumber: extensionNumber,
            extraWeeekHours: extraWeeekHours,
            speciality: speciality,
            weekSchedule: weekSchedule,
            clients: clients);
}
