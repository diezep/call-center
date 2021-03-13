import '../../../src/core/structures/list.dart';
import '../models/types.dart';
import 'package:flutter/material.dart';

import 'secretary.dart';

class Agent {
  int id, extensionNumber, workedHours;
  String name;
  AgentSpeciality speciality;
  MList<User> users; /* TODO: CHECK IF IS VALID*/
  DateTimeRange schedule; /* TODO: CHECK IF IS VALID*/
  /* TODO: ADD EXTRA HOURS */
}
