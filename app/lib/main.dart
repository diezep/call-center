import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'dart:ffi';
import 'dart:io' show Platform, Directory, File;

import 'package:watcher/watcher.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

typedef native_add = Int32 Function(Int32 x, Int32 y);
typedef NativeAdd = int Function(int x, int y);

typedef write_File = Int32 Function();
typedef WriteFile = int Function();

class _MyAppState extends State<MyApp> {
  int addResult = 0;
  int Function(int x, int y) add;
  void Function() writeFile;

  @override
  void initState() {
    super.initState();
    // print(Directory.current.path);
    // var libraryPath = path.join('../', 'app_library', 'libhello.dylib');
    final dylib = DynamicLibrary.open('libhello.dylib');
    add = dylib.lookupFunction<native_add, NativeAdd>('native_sum');
    writeFile = dylib.lookupFunction<write_File, WriteFile>('writeInFile');
  }

  void nativeAdd([int x = 1, int y = 2]) {
    setState(() {
      addResult = add(x, y).toInt();
    });
  }

  void nativeWriteFile() {
    writeFile();
    setState(() {});
  }

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
            child: Column(
              children: [
                Text("$addResult"),
                StreamBuilder(
                  stream: PollingFileWatcher('sample.txt').events,
                  // .transform(utf8.decoder) // Decode bytes to UTF-8.
                  // .transform(LineSplitter())

                  builder: (context, snapshot) {
                    String text = File('sample.txt').readAsStringSync();
                    return Container(
                      child: Text(text ?? ''),
                    );
                  },
                ),
                ElevatedButton(onPressed: nativeWriteFile, child: Text('Add'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
