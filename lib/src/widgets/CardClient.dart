import 'package:call_center/src/core/models/agent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CardAgent extends StatelessWidget {
  final Agent agent;
  CardAgent({this.agent, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;

    return ListTile(
      title: Text(
        "",
        style: textTheme.overline,
      ),
      subtitle: Text(agent.name),
    );
  }
}
