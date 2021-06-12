import 'package:call_center/src/core/abstraction/CallBase.dart';
import 'package:call_center/src/core/abstraction/MDuration.dart';
import 'package:call_center/src/core/models/Date.dart';
import 'package:flutter/material.dart';

class Call extends CallBase {
  Call({
    String id,
    MDuration duration,
    Date date,
  }) : super(id: id, duration: duration, date: date) {
    id = UniqueKey().toString();
  }

  @override
  String toString() {
    String toStr = "";
    toStr += "$id";
    toStr += "$duration";
    toStr += "$date";
    return toStr;
  }

  @override
  bool operator ==(otherCall) => this.id = otherCall.id;

  static Call fromMap(Map<String, dynamic> map) => Call(
        id: map["id"],
        duration: MDuration.fromMap(map["duration"]),
        date: Date.fromMap(map["date"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "duration": duration.toMap(),
        "date": date.toMap(),
      };


  @override
  String get id => id;
  @override
  MDuration get duration => duration;
  @override
  Date get date => date;

 
  @override  
  set id(String newValue) => id = newValue;
  @override
  set duration(MDuration newValue) => duration = newValue;
  @override
  set date(Date newValue) => date = newValue;
}
