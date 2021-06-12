import 'package:call_center/src/core/structures/MLinkedList.dart';
import 'package:call_center/src/core/structures/MSimpleList.dart';
import 'package:call_center/src/providers/DiskProvider.dart';

testing() {
  MSimpleList<String> listStrings = MSimpleList();
  listStrings.add("1");
  listStrings.add("2");
  listStrings.add("3");
  listStrings.add("4");

  print(listStrings[0]);
  listStrings[0] = "0";
  print(listStrings[0]);

  print(listStrings);
}
