import 'package:call_center/src/core/enum/AgentSpecialty.dart';
import 'package:call_center/src/core/models/Agent.dart';
import 'package:call_center/src/core/values.dart';
import 'package:flutter/material.dart';

class AgentProfileScreen extends StatelessWidget {
  final Agent agent;
  AgentProfileScreen({Key key, @required this.agent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text('Perfil de Agente'),
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: ColorHelper.background,
        key: key,
        body: LayoutBuilder(builder: (context, constraints) {
          return Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            color: ColorHelper.backgroundContrast,
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
                      backgroundImage: agent.image != null
                          ? Image.network(agent.image).image
                          : null,
                    ),
                    SizedBox(width: 32),
                    Text(
                      agent.name,
                      style: textTheme.headline4.apply(fontWeightDelta: 2),
                    ),
                    Text(
                      "# ${agent.id ?? 'ID'}",
                      style: textTheme.caption,
                    ),
                  ],
                ),
                SizedBox(height: 32),
                SizedBox(
                  height: 48,
                  width: constraints.maxWidth,
                  child: TabBar(
                      indicator: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(10), // Creates border
                          color: ColorHelper.background),
                      tabs: [
                        Tab(
                          text: 'Información',
                        ),
                        Tab(text: 'Clientes'),
                      ]),
                ),
                Container(
                  height: 200,
                  child: TabBarView(children: [
                    Container(
                      margin: EdgeInsets.only(top: 32),
                      child: Wrap(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 48,
                        runSpacing: 32,
                        alignment: WrapAlignment.center,
                        children: [
                          infoText(textTheme.bodyText1, 'ID', agent.id),
                          infoText(textTheme.bodyText1, 'Nombre', agent.name),
                          infoText(
                            textTheme.bodyText1,
                            'Clientes',
                            "${agent.clients?.length ?? 0}",
                          ),
                          infoText(
                            textTheme.bodyText1,
                            'Horas extras trabajadas',
                            "${agent.extraWeeekHours ?? 0}",
                          ),
                          infoText(textTheme.bodyText1, 'Número de extensión',
                              agent.extensionNumber),
                          infoText(textTheme.bodyText1, 'Especialidad',
                              agentSpecialityToString(agent.speciality)),
                        ],
                      ),
                    ),
                    agent.clients != null
                        ? ListView(
                            children:
                                agent.clients.toWidgets((e) => Text(e.name)) ??
                                    Text(''),
                          )
                        : Center(
                            child:
                                Text('La lista de clientes se encuentra vacía'),
                          ),
                  ]),
                )
              ],
            ),
          );
        }),
      ),
    );
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
}
