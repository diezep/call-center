import 'package:call_center/src/screens/agent_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key key}) : super(key: key);
  static String routeName = '/';

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Stack(
            children: [
              Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 64),
                    child: Text(
                      'Call\nCenter',
                      style: textTheme.headline2
                          .apply(fontWeightDelta: 3, color: Colors.black),
                    ),
                  )),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                        onPressed: () =>
                            _navigateToRoute(context, AgentScreen.routeName),
                        child: Text('COMO AGENTE')),
                    SizedBox(height: 16),
                    ElevatedButton(
                        onPressed: () => _navigateToRoute(context, routeName),
                        child: Text('COMO SECRETARIA')),
                    SizedBox(height: 16),
                    ElevatedButton(
                        onPressed: () => _navigateToRoute(context, routeName),
                        child: Text('COMO ADMINISTRADOR')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToRoute(context, String routeName) =>
      Navigator.of(context).pushReplacementNamed(routeName);
}
