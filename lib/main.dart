import 'package:call_center/src/core/values.dart';
import 'package:call_center/src/screens/dashboard_screen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Call Center',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: ColorHelper.background,
        backgroundColor: ColorHelper.background,
        cardColor: ColorHelper.backgroundContrast,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: ColorHelper.primaryElevatedButtonColor,
          ),
        ),
      ),
      home: DashboardScreen(),
    );
  }
}
