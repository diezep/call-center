import 'package:call_center/src/core/abstraction/ClientBase.dart';
import 'package:call_center/src/core/models/Call.dart';
import 'package:call_center/src/core/abstraction/MList.dart';
import 'package:call_center/src/core/structures/MSimpleList.dart';

class Client extends ClientBase {
  Client(
      {String id,
      String name = 'Nombre de cliente',
      MSimpleList<Call> calls,
      String telephoneNumber})
      : super(
            name: name, calls: calls, id: id, telephoneNumber: telephoneNumber);

  @override
  String toString() => "$id | $name | $telephoneNumber | ${calls.toString()}";

  @override
  void addCall(call) => this.calls.add(call);

  @override
  bool operator ==(otherClient) => this.id == otherClient.id;
}
