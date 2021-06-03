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
  }
}
