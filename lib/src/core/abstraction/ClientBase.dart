import 'package:call_center/src/core/models/Call.dart';
import 'package:call_center/src/core/structures/MSimpleList.dart';

abstract class ClientBase {
  String id;
  String name;
  String telephoneNumber;
  MSimpleList<Call> calls;

  ClientBase({this.id, this.name, this.telephoneNumber, this.calls});

  bool operator ==(otherClient);

  @override
  String toString();

  @override
  int get hashCode => super.hashCode;

  void addCall(call);
}
