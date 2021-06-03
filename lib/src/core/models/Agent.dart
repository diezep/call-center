import 'package:call_center/src/core/abstraction/AgentBase.dart';
import 'package:call_center/src/core/abstraction/WeekSchedule.dart';
import 'package:call_center/src/core/enum/AgentSpecialty.dart';
import 'package:call_center/src/core/models/Client.dart';
import 'package:call_center/src/core/abstraction/MList.dart';
import 'package:call_center/src/core/structures/MSimpleList.dart';

class Agent extends AgentBase {
  Agent({
    MSimpleList<Client> clients,
    String name = 'Diego Zepeda',
    String id,
    String image,
    String extensionNumber,
    int extraWeeekHours,
    AgentSpeciality speciality = AgentSpeciality.NoSelected,
  }) : super(
            name: name,
            id: id,
            image: image,
            extensionNumber: extensionNumber,
            extraWeeekHours: extraWeeekHours,
            speciality: speciality,
            clients: clients);

  @override
  String toString() {
    return name;
  }
}
