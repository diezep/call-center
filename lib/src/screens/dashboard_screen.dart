import 'dart:ui';

import 'package:call_center/src/core/models/Agent.dart';
import 'package:call_center/src/core/structures/MSimpleList.dart';
import 'package:call_center/src/core/values.dart';
import 'package:call_center/src/screens/agent/AgentsPage.dart';
import 'package:call_center/src/screens/home_screen.dart';
import 'package:call_center/src/widgets/DashboardCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AgentScreen extends StatefulWidget {
  AgentScreen({Key key}) : super(key: key);

  static String routeName = '/agent';

  @override
  _AgentScreenState createState() => _AgentScreenState();
}

class _AgentScreenState extends State<AgentScreen> {
  ThemeData theme;

  TextTheme textTheme;

  MSimpleList<Agent> listClientes = MSimpleList<Agent>();

  // Pages
  var agentsPage = AgentsPage();

  @override
  void initState() {
    super.initState();
    listClientes.add(Agent(name: 'Diego'));
    listClientes.add(Agent(name: 'Alberto'));
    listClientes.add(Agent(name: 'Zepeda'));
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    textTheme = theme.textTheme;
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: ColorHelper.background,
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
                    child: Text('Call Center',
                        style: textTheme.headline5
                            .apply(color: Colors.white, fontWeightDelta: 3)),
                  ),
                  DashboarCard(
                    icon: Icon(
                      Icons.person,
                      color: Colors.white10,
                    ),
                    primaryText: agentsPage.agents.length.toString(),
                    secondaryText: 'Agentes',
                    captionText: "${agentsPage.agents.length} MB",
                  ),
                  DashboarCard(
                    icon: Icon(
                      Icons.person_outline,
                      color: Colors.white10,
                    ),
                    primaryText: agentsPage.agents.length.toString(),
                    secondaryText: 'Clientes',
                    captionText: "${agentsPage.agents.length} MB",
                  ),
                  DashboarCard(
                    icon: Icon(
                      Icons.wifi_calling,
                      color: Colors.white10,
                    ),
                    primaryText: agentsPage.agents.length.toString(),
                    secondaryText: 'Llamadas',
                    captionText: "${agentsPage.agents.length} MB",
                  ),
                  SizedBox(height: 12),
                  Center(
                    child: ElevatedButton(
                      child: Text('ELIMINAR TODO'),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.red[900].withOpacity(0.7)),
                      onPressed: () {},
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: PageView(
                children: [
                  agentsPage,
                ],
              ),
            )
          ],
        ));
  }

  _logout(context) =>
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
}
