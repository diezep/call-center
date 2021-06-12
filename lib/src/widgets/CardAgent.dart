import 'dart:io';

import 'package:call_center/src/core/enum/AgentPopupMenu.dart';
import 'package:call_center/src/core/enum/AgentSpecialty.dart';
import 'package:call_center/src/core/models/Agent.dart';
import 'package:call_center/src/core/models/Call.dart';
import 'package:call_center/src/core/models/Client.dart';
import 'package:call_center/src/core/values.dart';
import 'package:call_center/src/widgets/AddAgentDialog.dart';
import 'package:call_center/src/screens/agent_screen.dart';
import 'package:call_center/src/widgets/Badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CardAgent extends StatelessWidget {
  final Agent agent;
  final void Function() onRemoveAgent, onRemoveClients;
  final Function(Agent) onUpdateAgent;
  final Function(Client) onAddClient, onRemoveClient;
  final void Function(Client, Call) onAddCall, onUpdateCall, onRemoveCall;

  CardAgent({
    this.agent,
    this.onRemoveAgent,
    this.onUpdateAgent,
    this.onAddClient,
    this.onRemoveClient,
    this.onAddCall,
    this.onUpdateCall,
    this.onRemoveCall,
    this.onRemoveClients,
    Key key,
  }) : super(key: key);

  ThemeData theme;
  TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    textTheme = theme.textTheme;

    return Container(
      width: 200,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(top: 16),
            child: Card(
              color: ColorHelper.backgroundContrast,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                margin: EdgeInsets.only(top: 20),
                padding: const EdgeInsets.only(top: 16.0),
                child: ListTile(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AgentProfileScreen(
                            agent: agent,
                            onAddClient: (Client newClient) =>
                                onAddClient(newClient),
                            onRemoveClient: (Client client) =>
                                onRemoveClient(client),
                            onAddCall: onAddCall,
                            onUpdateCall: (Client client, Call call) =>
                                onUpdateCall(client, call),
                            onRemoveCall: (Client client, Call call) =>
                                onRemoveCall(client, call),
                            onRemoveClients: onRemoveClients),
                      )),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  title: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(TextSpan(text: agent.name, children: [
                        TextSpan(
                          text: "  #${agent.id ?? 'ID'}  ",
                          style: textTheme.caption,
                        ),
                      ])),
                      SizedBox(height: 3),
                      Wrap(
                        spacing: 5,
                        runSpacing: 4,
                        children: [
                          Badge(
                            agentSpecialityToString(agent.speciality),
                            textStyle: textTheme.caption
                                .apply(color: ColorHelper.iconColor),
                            color: ColorHelper.iconColor.withOpacity(0.4),
                          ),
                          Text(
                            "${agent?.clients?.length ?? 0} CLIENTES",
                            style: textTheme.caption,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  margin: EdgeInsets.only(left: 16),
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    maxRadius: 32,
                    backgroundImage: agent?.image?.isNotEmpty ?? false
                        ? Image.file(File(agent.image)).image
                        : null,
                  )),
              Padding(
                padding: const EdgeInsets.only(right: 8.0, top: 24),
                child: PopupMenuButton(
                  offset: Offset(0, 50),
                  icon: Icon(Icons.more_vert),
                  onSelected: (AgentPopupMenu option) async {
                    switch (option) {
                      case AgentPopupMenu.UPDATE:
                        Agent tmpAgent = await showDialog(
                            context: context,
                            builder: (context) => AddAgentDialog(
                                  agent: agent,
                                ));
                        if (tmpAgent != null) onUpdateAgent(agent);

                        break;
                      case AgentPopupMenu.REMOVE:
                        onRemoveAgent();
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Text('Modificar'),
                      value: AgentPopupMenu.UPDATE,
                    ),
                    PopupMenuItem(
                      child: Text('Eliminar'),
                      value: AgentPopupMenu.REMOVE,
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
