import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Call Center',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Call Center'),
        ),
        body: Center(
          child: Container(
            child: Text('BURST!'),
          ),
        ),
      ),
    );
  }
}
