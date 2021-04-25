import 'package:call_center/src/core/structures/MSimpleList.dart';

testing() {
  MSimpleList<String> listStrings = MSimpleList();
  listStrings.add("Hola");
  listStrings.add("Como");
  listStrings.add("Estas");
  listStrings.add("Adios");

  listStrings.forEach((e) => e = "");
  // listStrings.sort();
  print(listStrings);
}
