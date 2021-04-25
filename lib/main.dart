import 'package:call_center/listtest.dart';
import 'package:call_center/src/screens/agent_screen.dart';
import 'package:call_center/src/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    testing();
    return MaterialApp(
      title: 'Call Center',
      initialRoute: HomeScreen.routeName,
      theme: ThemeData.light().copyWith(
          primaryColor: Colors.black,
          colorScheme: ColorScheme.light().copyWith(
            primary: Colors.black,
          )),
      routes: {
        HomeScreen.routeName: (_) => HomeScreen(),
        AgentScreen.routeName: (_) => AgentScreen(),
      },
    );
  }
}
