import 'package:call_center/src/core/abstraction/ClientBase.dart';
import 'package:call_center/src/core/models/Call.dart';
import 'package:call_center/src/core/structures/MSimpleList.dart';

class Client extends ClientBase {
  Client({
    this.id,
    this.name,
    this.calls,
    this.telephoneNumber,
  }) : super(
          name: name,
          calls: calls,
          id: id,
          telephoneNumber: telephoneNumber,
        );

  String id;
  String name;
  MSimpleList<Call> calls = MSimpleList();
  String telephoneNumber;

  @override
  String toString() => "$id|$name|$telephoneNumber|${calls.toString()}";

  @override
  void addCall(call) => this.calls.add(call);

  @override
  bool operator ==(otherClient) => this.id == otherClient.id;

  Map<String, dynamic> toMap() => <String, dynamic>{
        "id": id ?? '',
        "name": name ?? '',
        "telephone": telephoneNumber ?? '',
        "calls": [
          if (calls != null)
            for (var i = 0; i < calls.length; i++) calls[i].toMap()
        ]
      };

  static Client fromMap(Map<String, dynamic> map) {
    MSimpleList<Call> _calls = MSimpleList<Call>();
    if (map["calls"] != null)
      for (Map c in map['calls'] as List) _calls.add(Call.fromMap(c));

    return Client(
        id: map["id"],
        name: map["name"],
        telephoneNumber: map["telephoneNumber"],
        calls: _calls);
  }

  @override
  int get hashCode => super.hashCode;
}
