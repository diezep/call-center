import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({Key key, this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Confirmar acción'),
      content: Text('Estás a punto de $text, ¿deseas confirmar la acción?'),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context), child: Text('Descartar')),
        ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Confirmar')),
      ],
    );
  }
}
