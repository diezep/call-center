import 'dart:ui';

import 'package:call_center/src/core/models/Call.dart';
import 'package:call_center/src/core/models/Client.dart';
import 'package:call_center/src/core/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CardClient extends StatefulWidget {
  final Client client;
  final Function() onRemoveClient, onAddCall;
  final Function(Call call) onUpdateCall, onRemoveCall;

  CardClient({
    Key key,
    this.client,
    this.onRemoveClient,
    this.onAddCall,
    this.onUpdateCall,
    this.onRemoveCall,
  }) : super(key: key);

  @override
  _CardClientState createState() => _CardClientState();
}

class _CardClientState extends State<CardClient> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;

    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Stack(
            alignment: Alignment.center,
            children: [
              ExpansionTile(
                leading: Icon(Icons.person_outline),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text("NOMBRE", style: textTheme.caption),
                          Text(widget.client.name),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text("ID", style: textTheme.caption),
                          Text(
                            widget.client.id ?? 'SIN ID',
                            style: textTheme.bodyText1.apply(
                                fontStyle: (widget.client.id == null)
                                    ? FontStyle.italic
                                    : null),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text("TELEFONO", style: textTheme.caption),
                          Text(
                            widget.client.telephoneNumber ?? 'SIN TELEFONO',
                            style: textTheme.bodyText1.apply(
                                fontStyle:
                                    (widget.client.telephoneNumber == null)
                                        ? FontStyle.italic
                                        : FontStyle.normal),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text("LLAMADAS", style: textTheme.caption),
                          Text(
                            widget.client.calls.isEmpty
                                ? 'SIN LLAMADAS'
                                : widget.client.calls.length.toString(),
                            style: textTheme.bodyText1.apply(
                                fontStyle: (widget.client.calls.length == 0)
                                    ? FontStyle.italic
                                    : FontStyle.normal),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                children: [
                  for (int i = 0; i < widget.client.calls.length; i++)
                    ListTile(
                      leading: Icon(Icons.call),
                      title: Text(
                          "${widget.client.calls[i].date}   -   ${widget.client.calls[i].duration}"),
                      subtitle: Text("ID: ${widget.client.calls[i].id}"),
                      trailing: Wrap(
                        spacing: 10,
                        children: [
                          ElevatedButton(
                            child: Text("ELIMINAR"),
                            onPressed: () =>
                                widget.onRemoveCall(widget.client.calls[i]),
                            style: ElevatedButton.styleFrom(
                                primary: ColorHelper.dangerElevatedButtonColor),
                          ),
                          ElevatedButton(
                            child: Text("MODIFICAR"),
                            onPressed: () =>
                                widget.onUpdateCall(widget.client.calls[i]),
                          ),
                        ],
                      ),
                    )
                ],
                trailing: Container(
                  margin: EdgeInsets.only(right: 16),
                  child: Wrap(
                    spacing: 10,
                    children: [
                      ElevatedButton(
                        onPressed: widget.onRemoveClient,
                        style: ElevatedButton.styleFrom(
                            primary: ColorHelper.dangerElevatedButtonColor),
                        child: Text('ELIMINAR'),
                      ),
                      ElevatedButton(
                        onPressed: widget.onAddCall,
                        child: Text('AGREGAR LLAMADA'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
