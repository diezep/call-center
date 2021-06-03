import 'package:call_center/src/core/models/client.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CardClient extends StatelessWidget {
  final Client client;
  CardClient({this.client, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;

    return Container(
      child: ListTile(
        title: Text(
          "",
          style: textTheme.overline,
        ),
        subtitle: Text(client.name),
      ),
    );
  }
}
