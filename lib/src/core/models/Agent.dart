import 'package:call_center/src/core/abstraction/AgentBase.dart';
import 'package:call_center/src/core/enum/AgentSpecialty.dart';
import 'package:call_center/src/core/models/Client.dart';
import 'package:call_center/src/core/structures/MSimpleList.dart';

class Agent extends AgentBase {
  Agent({
    MSimpleList<Client> clients,
    String name,
    String id,
    String image,
    String extensionNumber,
    int extraWeeekHours,
    AgentSpeciality speciality = AgentSpeciality.NO_SELECTED,
  }) : super(
            name: name,
            id: id,
            image: image,
            extensionNumber: extensionNumber,
            extraWeeekHours: extraWeeekHours,
            speciality: speciality,
            clients: clients);

  @override
  String toString() => "$name $id $image $extensionNumber $speciality ";

  @override
  bool operator ==(otherAgent) => this.id == otherAgent.id;

  static Agent fromMap(Map<String, dynamic> map) {
    MSimpleList<Client> _clients = MSimpleList<Client>();
    if (map['clients'] != null)
      for (Map c in map['clients'] as List) _clients.add(Client.fromMap(c));

    return Agent(
      name: map["name"],
      id: map["id"],
      image: map["image"],
      extensionNumber: map["extensionNumber"],
      extraWeeekHours: map["extraWeeekHours"],
      speciality: agentSpecialityFromString(map["speciality"]),
      clients: _clients,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "name": name ?? '',
      "id": id ?? '',
      "image": image ?? '',
      "extensionNumber": extensionNumber ?? '',
      "extraWeeekHours": extraWeeekHours ?? 0,
      "speciality": agentSpecialityToString(speciality),
      "clients": [
        if (clients != null)
          for (int i = 0; i < clients.length; i++) clients[i].toMap()
      ]
    };
  }
}
