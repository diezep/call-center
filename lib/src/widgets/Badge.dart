import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Badge extends StatelessWidget {
  const Badge(this.text,
      {Key key, this.color = Colors.black, this.textStyle = const TextStyle()})
      : super(key: key);
  final String text;
  final Color color;
  final TextStyle textStyle;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: this.color,
      ),
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
      child: Text(text, style: textStyle),
    );
  }
}
