import 'dart:ui';

import 'package:call_center/src/core/abstraction/MList.dart';
import 'package:call_center/src/core/enum/AgentSpecialty.dart';
import 'package:call_center/src/core/enum/DataType.dart';
import 'package:call_center/src/core/enum/FilterAgents.dart';
import 'package:call_center/src/core/models/Agent.dart';
import 'package:call_center/src/core/models/Call.dart';
import 'package:call_center/src/core/models/Client.dart';
import 'package:call_center/src/core/models/DataInformation.dart';
import 'package:call_center/src/core/structures/MLinkedList.dart';
import 'package:call_center/src/core/structures/MSimpleList.dart';

import 'package:call_center/src/core/values.dart';
import 'package:call_center/src/providers/DiskProvider.dart';
import 'package:call_center/src/widgets/AddAgentDialog.dart';
import 'package:call_center/src/widgets/CardAgent.dart';

import 'package:call_center/src/widgets/DashboardCard.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key key}) : super(key: key);

  static String routeName = '/';

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // To get values from Theme
  ThemeData theme;
  TextTheme textTheme;

  // To show agents while are searching..
  MLinkedList<Agent> _agents = MLinkedList<Agent>();
  FilterAgents filterSelected = FilterAgents.NAME;
  String searchAgent;

  // To save on Disk
  DiskProvider diskProvider = DiskProvider();

  Future _readSavedData() async {
    MLinkedList<Agent> tmpAgents = await diskProvider.readFromDisk();
    setState(() {
      _agents = tmpAgents;
    });
  }

  // Statistics
  DataInformation get agentsInfo => DataInformation(
        _agents.toString().length,
        _agents.length,
        DataType.AGENTS,
      );

  DataInformation get clientsInfo => DataInformation(
      clients.toString().length, clients.length, DataType.CLIENTS);

  DataInformation get callsInfo =>
      DataInformation(calls.toString().length, calls.length, DataType.CALLS);

  // Agents to use searcher
  MLinkedList<Agent> get agents {
    if (searchAgent?.isEmpty ?? true)
      return _agents;
    else {
      MLinkedList<Agent> agentsShowed = MLinkedList<Agent>();
      _agents?.forEach((agent) {
        if (agent.name.toLowerCase().contains(searchAgent.toLowerCase()))
          agentsShowed.add(agent);
      });
      return agentsShowed;
    }
  }

  MLinkedList<Client> get clients {
    MLinkedList<Client> _clients = MLinkedList<Client>();
    _agents?.forEach((agent) {
      _clients.addAll(agent.clients);
    });

    return _clients;
  }

  MLinkedList<Call> get calls {
    MLinkedList<Call> _calls = MLinkedList<Call>();
    clients?.forEach((client) {
      _calls.addAll(client.calls);
    });

    return _calls;
  }

  @override
  void initState() {
    _readSavedData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    textTheme = theme.textTheme;
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
        body: Row(
      children: [
        Container(
          width: 250,
          height: screenSize.height,
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 32),
                padding: const EdgeInsets.symmetric(vertical: 16),
                alignment: Alignment.center,
                child: kAppIcon,
              ),
              DashboarCard(
                icon: Icon(
                  Icons.person,
                  color: Colors.white10,
                ),
                primaryText: agentsInfo.length.toString(),
                secondaryText: agentsInfo.textType,
                captionText: agentsInfo.bitsFormated,
                onAdd: _onAddAgent,
              ),
              DashboarCard(
                icon: Icon(
                  Icons.person_outline,
                  color: Colors.white10,
                ),
                primaryText: clientsInfo.length.toString(),
                secondaryText: clientsInfo.textType,
                captionText: clientsInfo.bitsFormated,
              ),
              DashboarCard(
                icon: Icon(
                  Icons.wifi_calling,
                  color: Colors.white10,
                ),
                primaryText: callsInfo.length.toString(),
                secondaryText: callsInfo.textType,
                captionText: callsInfo.bitsFormated,
              ),
              FutureBuilder<DataInformation>(
                  future: diskProvider.imagesInfo,
                  builder: (context, snapshot) {
                    DataInformation _data =
                        DataInformation(0, 0, DataType.IMAGES);
                    if (snapshot.hasData) _data = snapshot.data;
                    return DashboarCard(
                      icon: Icon(
                        Icons.image,
                        color: Colors.white10,
                      ),
                      primaryText: _data.length.toString(),
                      secondaryText: _data.textType,
                      captionText: _data.bitsFormated,
                    );
                  }),
              SizedBox(height: 12),
              Center(
                child: Wrap(
                  runAlignment: WrapAlignment.center,
                  runSpacing: 12,
                  spacing: 12,
                  alignment: WrapAlignment.center,
                  children: [
                    ElevatedButton(
                      child: Text('GUARDAR CAMBIOS'),
                      onPressed: _onSaveData,
                    ),
                    ElevatedButton(
                      child: Text('ELIMINAR TODO'),
                      style: ElevatedButton.styleFrom(
                          primary: ColorHelper.dangerElevatedButtonColor),
                      onPressed: _onRemoveData,
                    )
                  ],
                ),
              ),
              SizedBox(height: 18),
            ],
          ),
        ),
        Expanded(
          child: PageView(
            children: [
              Container(
                  height: screenSize.height,
                  padding: EdgeInsets.symmetric(horizontal: 48),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      bottomLeft: Radius.circular(32),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 48),
                        alignment: Alignment.topLeft,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Panel de administración',
                                style: textTheme.headline5
                                    .apply(fontWeightDelta: 3)),
                            SizedBox(height: 12),
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              alignment: WrapAlignment.center,
                              spacing: 10,
                              children: [
                                Container(
                                  width: 200,
                                  child: TextFormField(
                                    initialValue: searchAgent,
                                    onChanged: (v) =>
                                        setState(() => searchAgent = v),
                                    decoration: InputDecoration(
                                        fillColor: Colors.black12,
                                        filled: true,
                                        icon: Icon(Icons.search),
                                        labelText: 'Buscar agente',
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.never,
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none)),
                                  ),
                                ),
                                PopupMenuButton(
                                  offset: Offset(0, 50),
                                  tooltip: 'Filtrar',
                                  icon: Icon(Icons.filter_alt_outlined),
                                  onSelected: _onFilterSelected,
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      child: Text('Por especialidad'),
                                      value: FilterAgents.SPECIALITY,
                                    ),
                                    PopupMenuItem(
                                      child: Text('Por nombre'),
                                      value: FilterAgents.NAME,
                                    ),
                                    PopupMenuItem(
                                      child: Text('Por ID'),
                                      value: FilterAgents.ID,
                                    ),
                                    PopupMenuItem(
                                      child: Text('Por número de clientes'),
                                      value: FilterAgents.CLIENTS,
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Center(
                            child: (_agents.isEmpty)
                                ? Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(height: 128),
                                      Text('No se han agregado agentes aún',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic)),
                                    ],
                                  )
                                : Wrap(
                                    alignment: WrapAlignment.start,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.start,
                                    spacing: 16,
                                    runSpacing: 8,
                                    children: agents.toWidgets(
                                      (e) => CardAgent(
                                        agent: e,
                                        onRemoveAgent: () async {
                                          await diskProvider
                                              .removeAgentImage(e.id);
                                          setState(() => _agents.remove(e));
                                        },
                                        onUpdateAgent: (newElement) =>
                                            setState(() {
                                          imageCache.clear();
                                          imageCache.clearLiveImages();
                                          e = newElement;
                                        }),
                                        onAddClient: (Client newClient) =>
                                            setState(
                                                () => e.clients.add(newClient)),
                                        onRemoveClient: (Client client) =>
                                            setState(
                                                () => e.clients.remove(client)),
                                        onAddCall: (Client client, Call call) {
                                          int indexClient = e.clients
                                              .indexWhere((c) => c == client);
                                          setState(() {
                                            e.clients[indexClient]
                                                .addCall(call);
                                          });
                                        },
                                        onUpdateCall:
                                            (Client client, Call call) {
                                          int indexClient = e.clients
                                              .indexWhere((c) => c == client);
                                          int indexCall = e
                                              .clients[indexClient].calls
                                              .indexWhere((c) => c == call);

                                          setState(() {
                                            e.clients[indexClient]
                                                .calls[indexCall] = call;
                                          });
                                        },
                                        onRemoveCall:
                                            (Client client, Call call) {
                                          int indexClient = e.clients
                                              .indexWhere((c) => c == client);
                                          int indexCall = e
                                              .clients[indexClient].calls
                                              .indexWhere((c) => c == call);

                                          setState(() {
                                            e.clients[indexClient].calls
                                                .removeAt(indexCall);
                                          });
                                        },
                                        onRemoveClients: () =>
                                            setState(() => e.clients.clear()),
                                      ),
                                    )),
                          ),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        )
      ],
    ));
  }

  void _onRemoveData() async {
    try {
      await diskProvider.removeAgentImages();
    } catch (e) {}
    setState(() => _agents.clear());
    try {
      await diskProvider.writeInDisk(_agents);
    } catch (e) {}

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Agentes e información eliminada correctamente")));
  }

  void _onSaveData() async {
    await diskProvider.writeInDisk(_agents);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Agentes e información guardados correctamente")));
  }

  void _onAddAgent() async {
    Agent newAgent = await showDialog(
      context: context,
      builder: (context) => AddAgentDialog(),
    );
    if (newAgent != null) {
      setState(() {
        agents.add(newAgent);
      });
      diskProvider.writeInDisk(_agents);
    }
  }

  void _onFilterSelected(FilterAgents filter) {
    MSimpleList<Agent> agents = MSimpleList();

    _agents.forEach((e) => setState(() => agents.add(e)));

    switch (filter) {
      case FilterAgents.NAME:
        bool Function(Agent, Agent) filterByName = (Agent e1, Agent e2) =>
            e1.name.toLowerCase().compareTo(e2.name.toLowerCase()) == -1;

        mergeSortt(filterByName, agents, 0, agents.length - 1);
        break;

      case FilterAgents.ID:
        bool Function(Agent, Agent) filterById = (Agent e1, Agent e2) =>
            e1.id.toLowerCase().compareTo(e2.id.toLowerCase()) == -1;

        mergeSortt(filterById, agents, 0, agents.length - 1);
        break;

      case FilterAgents.CLIENTS:
        bool Function(Agent, Agent) filterByClients = (Agent e1, Agent e2) =>
            e1.clients.length.compareTo(e2.clients.length) == 1;

        mergeSortt(filterByClients, agents, 0, agents.length - 1);
        break;

      case FilterAgents.SPECIALITY:
        bool Function(Agent, Agent) filterBySpeciality = (Agent e1, Agent e2) =>
            agentSpecialityToString(e1.speciality)
                .compareTo(agentSpecialityToString(e2.speciality)) ==
            -1;

        mergeSortt(filterBySpeciality, agents, 0, agents.length - 1);
        break;
    }

    setState(() {
      _agents.clear();
      agents.forEach((entry) {
        _agents.add(entry);
      });
    });
  }

  void mergeSortt<E>(
      bool Function(E, E) compareFunction, MSimpleList<E> list, int l, int r) {
    if (l >= r) return;

    int m = l + (r - l) ~/ 2;

    mergeSortt(compareFunction, list, l, m);
    mergeSortt(compareFunction, list, m + 1, r);

    merge(compareFunction, list, l, m, r);
  }

  void merge<E>(
      bool Function(E, E) compareFunction, MList<E> list, int l, int m, int r) {
    var n1 = m - l + 1;
    var n2 = r - m;

    MSimpleList<E> L = MSimpleList(), R = MSimpleList();

    for (var i = 0; i < n1; i++) L.add(list[l + i]);
    for (var j = 0; j < n2; j++) R.add(list[m + 1 + j]);

    // Merge the temp arrays back into arr[l..r]

    // Initial index of first subarray
    var i = 0;

    // Initial index of second subarray
    var j = 0;

    // Initial index of merged subarray
    var k = l;

    while (i < n1 && j < n2) {
      if (compareFunction(L[i], R[j])) {
        list[k] = L[i];
        i++;
      } else {
        list[k] = R[j];
        j++;
      }

      k++;
    }

    // Copy the remaining elements of
    // L[], if there are any
    while (i < n1) {
      list[k] = L[i];
      i++;
      k++;
    }

    // Copy the remaining elements of
    // R[], if there are any
    while (j < n2) {
      list[k] = R[j];
      j++;
      k++;
    }
  }
}
