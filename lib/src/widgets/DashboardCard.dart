import 'package:call_center/src/core/values.dart';
import 'package:flutter/material.dart';

class DashboarCard extends StatelessWidget {
  DashboarCard(
      {Key key,
      @required this.primaryText,
      @required this.secondaryText,
      @required this.captionText,
      @required this.icon,
      this.onAdd})
      : super(key: key);
  final String primaryText, secondaryText, captionText;
  final Icon icon;
  final Function onAdd;
  ThemeData theme;
  TextTheme textTheme;
  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    textTheme = theme.textTheme;

    return Card(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  child: Icon(
                    icon.icon,
                    color: ColorHelper.iconColor,
                  ),
                  decoration: BoxDecoration(
                      color: ColorHelper.iconColor.withOpacity(.40),
                      borderRadius: BorderRadius.circular(12)),
                ),
                // PopupMenuButton(
                //   offset: Offset(0, 50),
                //   icon: Icon(Icons.more_vert,
                //       color: ColorHelper.iconVertColor,),
                //   onSelected: (value) async {
                //     print(value);
                //     if (value == 'Eliminar')
                //       onRemove();
                //     else if (value == 'Modificar') {
                //       Agent nAgent = await showDialog(
                //           context: context,
                //           builder: (context) => AddAgentDialog(
                //                 agent: agent,
                //               ));
                //       if (nAgent != null) onModified(agent);
                //     }
                //   },
                //   itemBuilder: (context) => [
                //     PopupMenuItem(
                //       child: Text('Modificar'),
                //       value: 'Modificar',
                //     ),
                //     PopupMenuItem(
                //       child: Text('Eliminar'),
                //       value: 'Eliminar',
                //     ),
                //   ],
                // ),
                // IconButton(
                //     icon: Icon(
                //       Icons.more_vert,
                //       color: ColorHelper.iconVertColor,
                //     ),
                //     onPressed: )
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text.rich(TextSpan(
                            text: "$primaryText  ",
                            style: textTheme.headline6
                                .apply(color: ColorHelper.primaryTextColor),
                            children: [
                              TextSpan(
                                  text: secondaryText,
                                  style: textTheme.headline6.apply(
                                      color: ColorHelper.secondTextColor))
                            ]))
                      ],
                    ),
                    Text(
                      captionText,
                      style: textTheme.button.apply(
                          fontWeightDelta: 2,
                          color: ColorHelper.primaryElevatedButtonColor
                              .withOpacity(0.5)),
                    )
                  ],
                ),
                if (onAdd != null)
                  Container(
                    width: 40,
                    height: 36,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: ElevatedButton(
                        onPressed: onAdd,
                        child: Icon(Icons.add),
                        style: ElevatedButton.styleFrom(),
                      ),
                    ),
                  )
              ],
            )
          ],
        ),
      ),
    );
  }
}
