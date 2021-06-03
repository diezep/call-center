import 'package:call_center/src/core/abstraction/MList.dart';
import 'package:call_center/src/core/enum/FilterAgents.dart';
import 'package:call_center/src/core/models/Agent.dart';
import 'package:call_center/src/core/structures/MSimpleList.dart';
import 'package:call_center/src/core/values.dart';
import 'package:call_center/src/providers/DiskProvider.dart';
import 'package:call_center/src/widgets/AddAgentDialog.dart';
import 'package:call_center/src/widgets/CardAgent.dart';
import 'package:flutter/material.dart';

class AgentsPage extends StatefulWidget {
  AgentsPage({Key key}) : super(key: key);

  MSimpleList<Agent> agents = MSimpleList<Agent>();
  MSimpleList<Agent> _agents = MSimpleList<Agent>();
  MSimpleList<Agent> agentsShowed = MSimpleList<Agent>();
  var filterSelected = FilterAgents.name;
  @override
  _AgentsPageState createState() => _AgentsPageState();
}

class _AgentsPageState extends State<AgentsPage> {
  @override
  void initState() {
    super.initState();
    setState(() {
      widget.agents.add(Agent(
          name: 'a',
          id: "ida",
          image: "https://randomuser.me/api/portraits/men/27.jpg"));
      widget.agents.add(Agent(name: 'b', id: "idb"));
      widget.agents.add(Agent(name: 'c', id: "idc"));
      widget.agents.add(Agent(name: 'd', id: "idd"));
      widget.agents.add(Agent(name: 'e', id: "ide"));
      widget.agents.add(Agent(name: 'g', id: "idg"));
      widget.agents.add(Agent(name: 'f', id: "idf"));
      widget.agents.add(Agent(name: 'e', id: "ide"));
      widget.agents.add(Agent(name: 'a', id: "ida"));
      widget.agents.add(Agent(name: 'o', id: "ido"));

      widget.agentsShowed = widget.agents;
    });
    // testing();
  }

  // Future testing() async {
  //   await DiskProvider().writeInDisk(widget.agents);
  //   setState(() {
  //     widget.agents.clear();
  //   });
  //   await Future.delayed(Duration(seconds: 5));
  //   MList<Agent> agents = await DiskProvider().readFromDisk();
  //   setState(() {
  //     widget.agents.addAll(agents);
  //   });
  // }

  String searchAgent;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: ColorHelper.background,
      floatingActionButton: Wrap(
        spacing: 8,
        children: [
          FloatingActionButton(
              tooltip: 'Eliminar todos los agentes',
              child: Icon(Icons.delete_forever),
              onPressed: () async {
                widget.agents.clear();
              }),
          FloatingActionButton(
              tooltip: 'Agregar agente nuevo',
              child: Icon(Icons.add),
              onPressed: () async {
                Agent newAgent = await showDialog(
                  context: context,
                  builder: (context) => AddAgentDialog(),
                );
                if (newAgent != null) {
                  setState(() {
                    widget.agents.add(newAgent);
                  });
                }
              }),
        ],
      ),
      body: Container(
          height: screenSize.height,
          padding: EdgeInsets.symmetric(horizontal: 48),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              bottomLeft: Radius.circular(32),
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Panel de administración',
                            style:
                                textTheme.headline5.apply(fontWeightDelta: 3)),
                        SizedBox(height: 12),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          alignment: WrapAlignment.center,
                          spacing: 10,
                          children: [
                            Container(
                              width: 200,
                              child: TextFormField(
                                initialValue: searchAgent,
                                onChanged: (v) {
                                  if (v.isEmpty ?? false)
                                    setState(() {
                                      widget.agentsShowed = widget.agents;
                                      searchAgent = v;
                                    });
                                },
                                decoration: InputDecoration(
                                    fillColor: Colors.black12,
                                    filled: true,
                                    icon: Icon(Icons.search),
                                    suffix: (searchAgent?.isNotEmpty ?? false)
                                        ? IconButton(
                                            icon: Icon(Icons.close),
                                            onPressed: () => setState(() {
                                              searchAgent = null;
                                            }),
                                          )
                                        : null,
                                    labelText: 'Buscar agente',
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none)),
                              ),
                            ),
                            PopupMenuButton(
                              offset: Offset(0, 50),
                              tooltip: 'Filtrar',
                              icon: Icon(Icons.filter_alt_outlined),
                              onSelected: (enumValue) async {
                                switch (enumValue) {
                                  case FilterAgents.name:
                                    List<Agent> agents = [];
                                    widget.agents.forEach((e) {
                                      setState(() {
                                        agents.add(e);
                                      });
                                    });
                                    print(agents);
                                    setState(() {
                                      mergeSort(enumValue, agents, 0,
                                          agents.length - 1);
                                    });

                                    break;
                                  default:
                                }
                              },
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  child: Text('Por especialidad'),
                                  value: FilterAgents.speciality,
                                ),
                                PopupMenuItem(
                                  child: Text('Por nombre'),
                                  value: FilterAgents.name,
                                ),
                                PopupMenuItem(
                                  child: Text('Por ID'),
                                  value: FilterAgents.id,
                                ),
                                PopupMenuItem(
                                  child: Text('Por número de clientes'),
                                  value: FilterAgents.clientes,
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Wrap(
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      spacing: 16,
                      runSpacing: 8,
                      children: widget.agents.toWidgets(
                        (e) => CardAgent(
                          agent: e,
                          onRemove: () async => setState(
                            () => widget.agents.remove(e),
                          ),
                          onModified: (newElement) async {
                            setState(() => e = newElement);
                          },
                        ),
                      )),
                ],
              ),
            ),
          )),
    );
  }
/*function merge(arr, l, m, r)
{
    var n1 = m - l + 1;
    var n2 = r - m;
 
    // Create temp arrays
    var L = new Array(n1);
    var R = new Array(n2);
 
    // Copy data to temp arrays L[] and R[]
    for (var i = 0; i < n1; i++)
        L[i] = arr[l + i];
    for (var j = 0; j < n2; j++)
        R[j] = arr[m + 1 + j];
 
    // Merge the temp arrays back into arr[l..r]
 
    // Initial index of first subarray
    var i = 0;
 
    // Initial index of second subarray
    var j = 0;
 
    // Initial index of merged subarray
    var k = l;
 
    while (i < n1 && j < n2) {
        if (L[i] <= R[j]) {
            arr[k] = L[i];
            i++;
        }
        else {
            arr[k] = R[j];
            j++;
        }
        k++;
    }
 
    // Copy the remaining elements of
    // L[], if there are any
    while (i < n1) {
        arr[k] = L[i];
        i++;
        k++;
    }
 
    // Copy the remaining elements of
    // R[], if there are any
    while (j < n2) {
        arr[k] = R[j];
        j++;
        k++;
    }
}
 
// l is for left index and r is
// right index of the sub-array
// of arr to be sorted
function mergeSort(arr,l, r){
    if(l>=r){
        return;//returns recursively
    }
    var m =l+ parseInt((r-l)/2);
    mergeSort(arr,l,m);
    mergeSort(arr,m+1,r);
    merge(arr,l,m,r);
}
 */
// If r > l
//      1. Find the middle point to divide the array into two halves:
//              middle m = l+ (r-l)/2
//      2. Call mergeSort for first half:
//              Call mergeSort(arr, l, m)
//      3. Call mergeSort for second half:
//              Call mergeSort(arr, m+1, r)
//      4. Merge the two halves sorted in step 2 and 3:
//              Call merge(arr, l, m, r)

  void mergeSort(FilterAgents filterBy, List<Agent> agents, int l, int r) {
    if (l >= r) return;

    int m = l + (r - l) ~/ 2;

    mergeSort(filterBy, agents, l, m);
    mergeSort(filterBy, agents, m + 1, r);

    merge(filterBy, agents, l, m, r);
    if (agents.length == widget.agents.length) print(agents);
  }

  List<Agent> merge(
      FilterAgents filterBy, List<Agent> agents, int l, int m, int r) {
    var n1 = m - l + 1;
    var n2 = r - m;

    List<Agent> L = [], R = [];

    for (var i = 0; i < n1; i++) L.add(agents[l + i]);
    for (var j = 0; j < n2; j++) R.add(agents[m + 1 + j]);

    // Merge the temp arrays back into arr[l..r]

    // Initial index of first subarray
    var i = 0;

    // Initial index of second subarray
    var j = 0;

    // Initial index of merged subarray
    var k = l;

    while (i < n1 && j < n2) {
      switch (filterBy) {
        case FilterAgents.name:
          if (L[i].name.compareTo(R[j].name) == -1) {
            agents[k] = L[i];
            i++;
          } else {
            agents[k] = R[j];
            j++;
          }
          break;
        default:
      }

      k++;
    }

    // Copy the remaining elements of
    // L[], if there are any
    while (i < n1) {
      agents[k] = L[i];
      i++;
      k++;
    }

    // Copy the remaining elements of
    // R[], if there are any
    while (j < n2) {
      agents[k] = R[j];
      j++;
      k++;
    }
  }
}
