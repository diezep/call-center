import 'package:call_center/src/core/abstraction/MDuration.dart';
import 'package:call_center/src/core/models/Call.dart';
import 'package:call_center/src/core/models/Date.dart';
import 'package:call_center/src/core/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddCallDialog extends StatefulWidget {
  Call call;
  AddCallDialog({Key key, this.call}) : super(key: key);

  @override
  _AddCallDialogState createState() => _AddCallDialogState();
}

class _AddCallDialogState extends State<AddCallDialog> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool newCall = false;
  @override
  void initState() {
    super.initState();
    if (widget.call == null) {
      Date now = Date.now();
      String randomId = generateRandomId();

      setState(() {
        newCall = true;

        widget.call = Call(id: randomId, date: now, duration: MDuration());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        !newCall ? 'Modificar llamada' : 'Nueva llamada',
        textAlign: TextAlign.center,
      ),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              initialValue: generateRandomId(),
              enabled: false,
              decoration: InputDecoration(labelText: 'ID'),
              autovalidateMode: AutovalidateMode.always,
              readOnly: true,
            ),
            SizedBox(height: 16),
            TextFormField(
              enabled: false,
              initialValue: widget?.call?.date.toString() ?? '',
              decoration: InputDecoration(labelText: 'Fecha'),
              readOnly: true,
              autovalidateMode: AutovalidateMode.always,
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: "${widget?.call?.duration?.hours ?? ''}",
                    decoration: InputDecoration(labelText: 'Horas'),
                    autovalidateMode: AutovalidateMode.always,
                    validator: (value) {
                      if (value.isEmpty) return 'REQUERIDO';
                      if (int.tryParse(value) == null)
                        return 'Sólo números enteros.';
                      int intValue = int.parse(value);
                      if (intValue < 0 || intValue > 59) return 'INVALIDO';

                      return null;
                    },
                    onSaved: (value) => setState(() => setState(() =>
                        widget?.call?.duration?.hours = int.parse(value))),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    initialValue: "${widget?.call?.duration?.minutes ?? ''}",
                    decoration: InputDecoration(labelText: 'Minutos'),
                    autovalidateMode: AutovalidateMode.always,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.isEmpty) return 'REQUERIDO';
                      if (int.tryParse(value) == null)
                        return 'Sólo números enteros';
                      int intValue = int.parse(value);
                      if (intValue < 0 || intValue > 59) return 'INVALIDO';

                      return null;
                    },
                    onSaved: (value) => setState(() => setState(() =>
                        widget?.call?.duration?.minutes = int.parse(value))),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context), child: Text('Descartar')),
        ElevatedButton(
            onPressed: () => _onSave(context), child: Text('Guardar'))
      ],
    );
  }

  _onSave(context) {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      Navigator.pop(context, widget.call);

      String newCallMessage = 'Se ha agregado una nueva llamada correctamente';
      String updateCallMessage = 'Se ha modificado la llamada correctamente';
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(newCall ? newCallMessage : updateCallMessage)));
    }
  }
}
