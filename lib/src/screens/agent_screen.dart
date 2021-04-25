import 'package:call_center/src/core/models/client.dart';
import 'package:call_center/src/core/structures/MSimpleList.dart';
import 'package:call_center/src/screens/home_screen.dart';
import 'package:call_center/src/widgets/CardAgent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AgentScreen extends StatelessWidget {
  AgentScreen({Key key}) : super(key: key);

  static String routeName = '/agent';
  ThemeData theme;
  TextTheme textTheme;

  MSimpleList<Client> listClientes = MSimpleList<Client>();

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    textTheme = theme.textTheme;

    listClientes.add(Client(name: 'Diego'));
    listClientes.add(Client(name: 'Alberto'));
    listClientes.add(Client(name: 'Zepeda'));

    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverOverlapAbsorber(handle: SliverOverlapAbsorberHandle()),
                SliverAppBar(
                  centerTitle: false,
                  // expandedHeight: 200,
                  toolbarHeight: 76,
                  title: Row(
                    children: [
                      CircleAvatar(),
                      SizedBox(width: 16),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Panel de Agente',
                            style: textTheme.caption.apply(color: Colors.white),
                          ),
                          Text('Nombre de agente'),
                        ],
                      ),
                    ],
                  ),

                  actions: [
                    IconButton(
                        icon: Icon(Icons.logout),
                        onPressed: () => _logout(context))
                  ],
                )
              ],
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text('Clients',
                        style: textTheme.headline6.apply(fontWeightDelta: 1)),
                  ),
                  SizedBox(height: 10),
                  ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (_, __) => SizedBox(height: 2),
                    itemCount: listClientes.length,
                    itemBuilder: (context, i) =>
                        CardClient(client: listClientes[i]),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  _logout(context) =>
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
}
