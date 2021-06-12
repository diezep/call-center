import 'dart:convert';
import 'dart:io';

import 'package:call_center/src/core/abstraction/MList.dart';
import 'package:call_center/src/core/enum/DataType.dart';
import 'package:call_center/src/core/models/Agent.dart';
import 'package:call_center/src/core/models/DataInformation.dart';
import 'package:call_center/src/core/models/Date.dart';
import 'package:call_center/src/core/structures/MLinkedList.dart';

import 'package:call_center/src/core/values.dart';
import 'package:path_provider/path_provider.dart';

class DiskProvider {
  // Paths
  String agentsPath = kDbName;
  String agentsImagesDirPath = "agents-images";

  Future writeInDisk(MList<Agent> agents) async {
    Map<String, dynamic> mapToJson = {
      "agents": [
        for (int i = 0; i < agents.length; i++) agents[i].toJson(),
      ]
    };

    String json = jsonEncode(mapToJson);

    File file = await _localFile(agentsPath);
    file.writeAsString(json);

    print("Guardado en memoria: ${Date.now()}");
  }

  Future<MLinkedList<Agent>> readFromDisk() async {
    MLinkedList<Agent> _agents = MLinkedList<Agent>();
    File file = await _localFile(agentsPath);
    if (!await file.exists()) return _agents;
    String jsonEncoded = await file.readAsString();

    Map<String, dynamic> mapJson = jsonDecode(jsonEncoded);

    for (Map agent in mapJson["agents"] as List) {
      _agents.add(Agent.fromMap(agent));
    }

    print("Leído desde memoria: ${DateTime.now()}");
    return _agents;
  }

  /// Get the information about Images directory
  Future<DataInformation> get imagesInfo async {
    Directory _imagesDir = await _localDirectory(agentsImagesDirPath);
    if (!await _imagesDir.exists())
      return DataInformation(0, 0, DataType.IMAGES);
    int _sizeBits = 0, _length = 0;

    try {
      _imagesDir
          .listSync(recursive: true, followLinks: false)
          .forEach((FileSystemEntity entity) {
        if (entity is File) {
          _sizeBits += entity.lengthSync();
          _length++;
        }
      });
    } catch (e) {
      print(e.toString());
    }

    return DataInformation(_sizeBits, _length, DataType.IMAGES);
  }

  Future<void> removeAgentImage(String nameImage) async {
    Directory dirAgentImages = await _localDirectory(agentsImagesDirPath);
    if (!await dirAgentImages.exists()) return;

    File fileToRemove = File("${dirAgentImages.absolute.path}/$nameImage.jpg");

    fileToRemove.deleteSync();
  }

  Future<String> saveImageAgent(
      String nameImage, String imagePathToSave) async {
    Directory dirAgentImages = await _localDirectory(agentsImagesDirPath);
    if (!await dirAgentImages.exists()) dirAgentImages.create();

    File fileToCopy = File(imagePathToSave);

    File newFile =
        await fileToCopy.copy("${dirAgentImages.absolute.path}/$nameImage.jpg");

    return newFile.path;
  }

  Future<void> removeAgentImages() async {
    String appPath = await _localPath;

    Directory dirAgentImages = Directory("$appPath/$agentsImagesDirPath");

    await dirAgentImages.delete(recursive: true);
  }
}

Future<String> get _localPath async {
  final localPath = await getApplicationDocumentsDirectory();
  return localPath.path;
}

Future<File> _localFile(String fileName) async {
  final path = await _localPath;
  return File('$path/$fileName');
}

Future<Directory> _localDirectory(String dirName) async {
  final path = await _localPath;
  return Directory('$path/$dirName');
}

dynamic parseNull(String str) => str == "null" ? null : str;
