import 'dart:convert';
import 'dart:io';

import 'package:call_center/src/core/abstraction/MDuration.dart';
import 'package:call_center/src/core/abstraction/MList.dart';
import 'package:call_center/src/core/enum/AgentSpecialty.dart';
import 'package:call_center/src/core/models/Agent.dart';
import 'package:call_center/src/core/models/Call.dart';
import 'package:call_center/src/core/models/Client.dart';
import 'package:call_center/src/core/models/Date.dart';
import 'package:call_center/src/core/structures/MSimpleList.dart';
import 'package:path_provider/path_provider.dart';

class DiskProvider {
  String delimitator = "+-+-+";

  // Paths
  String agentsPath = "agents.txt";
  String clientsPath = "clients.txt";
  String callsPath = "calls.txt";

  Future writeInDisk(MList<Agent> agents) async {
    String agentsToWrite = "";
    String clientsToWrite = "";
    String callsToWrite = "";

    MList<Call> _callsToSave = MSimpleList<Call>();
    MList<Client> _clientsToSave = MSimpleList<Client>();

    agents.forEach((a) {
      agentsToWrite += "${a.id}\n";
      agentsToWrite += "${a.name}\n";
      agentsToWrite += "${a.image}\n";
      agentsToWrite += "${a.extraWeeekHours}\n";
      agentsToWrite += "${a.extensionNumber}\n";
      agentsToWrite += "${agentSpecialityToString(a.speciality)}\n";
      agentsToWrite += "$delimitator\n";

      if (a.clients != null && a.clients.length > 0)
        _clientsToSave.addAll(a.clients);
    });

    _clientsToSave?.forEach((c) {
      clientsToWrite += "${c.id}\n";
      clientsToWrite += "${c.name}\n";
      clientsToWrite += "${c.telephoneNumber}\n";
      clientsToWrite += "$delimitator\n";

      if (c.calls != null && c.calls.length > 0) _callsToSave.addAll(c.calls);
    });

    _callsToSave?.forEach((c) {
      callsToWrite += "${c.id}\n";
      callsToWrite += "${c.duration}\n";
      callsToWrite += "${c.date}\n";
      callsToWrite += "$delimitator\n";
    });

    var file = await _localFile(agentsPath);
    file.writeAsString('$agentsToWrite');

    file = await _localFile(clientsPath);
    file.writeAsString('$clientsToWrite');

    file = await _localFile(callsPath);
    file.writeAsString('$callsToWrite');

    print("Escrito en disco.");
  }

  Future<MList<Agent>> readFromDisk() async {
    MList<Agent> agents = MSimpleList<Agent>();
    MList<Client> clients = MSimpleList<Client>();
    MList<Call> calls = MSimpleList<Call>();
    int i = 0;

    // Agents
    final fileAgents = await _localFile(agentsPath);
    final contentsAgents = fileAgents.readAsLinesSync();
    while (i < contentsAgents.length) {
      Agent nAgent = Agent(
        id: parseNull(contentsAgents[i++]),
        name: parseNull(contentsAgents[i++]),
        image: parseNull(contentsAgents[i++]),
        extraWeeekHours: (parseNull(contentsAgents[i++]) ?? 0) as int,
        extensionNumber: parseNull(contentsAgents[i++]),
        speciality: agentSpecialityFromString(contentsAgents[i++]),
      );
      agents.add(nAgent);
      i++;
    }

    // Clients
    final fileClients = await _localFile(clientsPath);
    final contentsClients = await fileClients.readAsLinesSync();
    i = 0;
    while (i < contentsClients.length) {
      Client nClient = Client(
        id: parseNull(contentsClients[i++]),
        name: parseNull(contentsClients[i++]),
        telephoneNumber: parseNull(contentsClients[i++]),
      );
      clients.add(nClient);
      i++;
    }

    // Calls
    final fileCalls = await _localFile(clientsPath);
    final contentsCalls = await fileCalls.readAsLinesSync();
    i = 0;
    while (i < contentsCalls.length) {
      Call nCall = Call(
        id: parseNull(contentsCalls[i++]),
        duration: parseNull(contentsCalls[i++]) as MDuration,
        date: parseNull(contentsCalls[i++]) as Date,
      );
      calls.add(nCall);
      i++;
    }

    return agents;
  }
}

Future<String> get _localPath async {
  final localPath = await getApplicationDocumentsDirectory();
  return localPath.path;
}

Future<File> _localFile(String fileName) async {
  final path = await _localPath;
  return File('$path/$fileName');
}

dynamic parseNull(String str) => str == "null" ? null : str;

/*
{
  "clients" : [
    {
      "id"
      "name"
      "agentId"
    }
  ],
  "agents" : [
    {
      "id"
      "name"
      ...
    },
    {
      "id"
      "name"
      ...
    },
  ],
  "calls":[
    {
      "id"
      "clientId"
      "agentId"
    },
    {
      "id"
      "clientId"
      "agentId"
    },
  ]
}*/