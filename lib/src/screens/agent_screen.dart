import 'dart:io';

import 'package:call_center/src/core/enum/AgentSpecialty.dart';
import 'package:call_center/src/core/models/Agent.dart';
import 'package:call_center/src/core/models/Call.dart';
import 'package:call_center/src/core/models/Client.dart';
import 'package:call_center/src/core/values.dart';
import 'package:call_center/src/widgets/AddCallDialog.dart';
import 'package:call_center/src/widgets/AddClientDialog.dart';
import 'package:call_center/src/widgets/CardClient.dart';
import 'package:flutter/material.dart';

class AgentProfileScreen extends StatefulWidget {
  AgentProfileScreen({
    Key key,
    @required this.agent,
    this.onAddClient,
    this.onRemoveClient,
    this.onUpdateCall,
    this.onRemoveCall,
    this.onAddCall,
    this.onRemoveClients,
  }) : super(key: key);

  final Agent agent;

  void Function() onRemoveClients;
  final Function(Client) onAddClient, onRemoveClient;
  final Function(Client, Call) onUpdateCall, onAddCall, onRemoveCall;

  @override
  _AgentProfileScreenState createState() => _AgentProfileScreenState();
}

class _AgentProfileScreenState extends State<AgentProfileScreen>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  bool showAddButton = false;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      setState(() => showAddButton = tabController.index == 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;

    return Scaffold(
        floatingActionButton: AnimatedCrossFade(
            firstChild: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 36,
                  child: ElevatedButton(
                    onPressed: (widget?.agent?.clients?.isNotEmpty ?? false)
                        ? _onRemoveClients
                        : null,
                    child: Text('ELIMINAR CLIENTES'),
                    style: ElevatedButton.styleFrom(
                        primary: ColorHelper.dangerElevatedButtonColor),
                  ),
                ),
                SizedBox(width: 16),
                Container(
                  width: 40,
                  height: 36,
                  child: ElevatedButton(
                    onPressed: _onAddClient,
                    child: Icon(Icons.add),
                    style: ElevatedButton.styleFrom(),
                  ),
                ),
              ],
            ),
            secondChild: Container(width: 300, height: 36),
            crossFadeState: showAddButton
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration: Duration(milliseconds: 600)),
        appBar: AppBar(
          elevation: 0,
          title: Text('Perfil de Agente'),
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: ColorHelper.background,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: ColorHelper.background,
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 32),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.black,
                    maxRadius: 64,
                    backgroundImage: widget?.agent?.image?.isNotEmpty ?? false
                        ? Image.file(File(widget.agent.image)).image
                        : null,
                  ),
                  SizedBox(width: 32),
                  Text(
                    widget.agent.name,
                    style: textTheme.headline4.apply(fontWeightDelta: 2),
                  ),
                  Text("# ${widget.agent.id ?? 'ID'}",
                      style: textTheme.caption),
                ],
              ),
              SizedBox(height: 32),
              SizedBox(
                height: 48,
                width: MediaQuery.of(context).size.width,
                child: TabBar(
                    controller: tabController,
                    indicator: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(10), // Creates border
                        color: ColorHelper.backgroundContrast),
                    tabs: [
                      Tab(text: 'Información'),
                      Tab(text: 'Clientes'),
                    ]),
              ),
              Expanded(
                child: TabBarView(controller: tabController, children: [
                  Container(
                    margin: EdgeInsets.only(top: 32),
                    child: Wrap(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 48,
                      runSpacing: 32,
                      alignment: WrapAlignment.center,
                      children: [
                        infoText(textTheme.bodyText1, 'ID', widget.agent.id),
                        infoText(
                            textTheme.bodyText1, 'Nombre', widget.agent.name),
                        infoText(
                          textTheme.bodyText1,
                          'Clientes',
                          "${widget.agent.clients?.length ?? 0}",
                        ),
                        infoText(
                          textTheme.bodyText1,
                          'Horas extras trabajadas',
                          "${widget.agent.extraWeeekHours ?? 0}",
                        ),
                        infoText(textTheme.bodyText1, 'Número de extensión',
                            widget.agent.extensionNumber),
                        infoText(textTheme.bodyText1, 'Especialidad',
                            agentSpecialityToString(widget.agent.speciality)),
                      ],
                    ),
                  ),
                  widget.agent.clients.isNotEmpty
                      ? ListView(
                          children: widget.agent.clients
                              .toWidgets((client) => CardClient(
                                    client: client,
                                    onRemoveClient: () =>
                                        _onRemoveClient(client),
                                    onAddCall: () => _onAddCall(client),
                                    onUpdateCall: (Call call) =>
                                        _onUpdateCall(client, call),
                                    onRemoveCall: (Call call) =>
                                        _onRemoveCall(client, call),
                                  )))
                      : Center(
                          child:
                              Text('La lista de clientes se encuentra vacía'),
                        ),
                ]),
              )
            ],
          ),
        ));
  }

  void _onAddClient() async {
    Client newClient = await showDialog(
      context: context,
      builder: (context) => AddClientDialog(),
    );
    if (newClient != null) widget.onAddClient(newClient);
    setState(() {});
  }

  void _onRemoveClient(Client client) async {
    widget.onRemoveClient(client);
    setState(() {});
  }

  void _onAddCall(Client client) async {
    Call newCall = await showDialog(
      context: context,
      builder: (context) => AddCallDialog(),
    );
    if (newCall != null) widget.onAddCall(client, newCall);
    setState(() {});
  }

  void _onUpdateCall(Client client, Call call) async {
    Call newCall = await showDialog(
      context: context,
      builder: (context) => AddCallDialog(call: call),
    );
    if (newCall != null) {
      call.duration = newCall.duration;
      widget.onUpdateCall(client, call);
    }
    setState(() {});
  }

  void _onRemoveCall(Client client, Call call) async {
    widget.onRemoveCall(client, call);

    setState(() {});
  }

  void _onRemoveClients() {
    widget.onRemoveClients();
    setState(() {});
  }
}

Widget infoText(styleText, [String info, String data = 'No definido']) =>
    Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          info,
          style: styleText,
        ),
        Text(data ?? 'No definido')
      ],
    );
