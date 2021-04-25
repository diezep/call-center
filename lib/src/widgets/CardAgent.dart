import 'package:call_center/src/core/models/client.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CardClient extends StatelessWidget {
  final Client client;
  CardClient({this.client, Key key}) : super(key: key);

  ThemeData theme;
  TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    textTheme = theme.textTheme;

    return Card(
      elevation: 0,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${client.calls ?? 0} LLAMADAS",
              style: textTheme.caption,
            ),
            SizedBox(height: 3),
            Text(client.name),
          ],
        ),
        trailing: IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
      ),
    );
  }
}
