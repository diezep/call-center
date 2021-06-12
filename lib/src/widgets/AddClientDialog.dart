import 'package:call_center/src/core/models/Call.dart';
import 'package:call_center/src/core/models/Client.dart';
import 'package:call_center/src/core/structures/MSimpleList.dart';
import 'package:call_center/src/core/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddClientDialog extends StatefulWidget {
  Client client;
  AddClientDialog({Key key, this.client}) : super(key: key);

  @override
  _AddClientDialogState createState() => _AddClientDialogState();
}

class _AddClientDialogState extends State<AddClientDialog> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool newClient = false;
  @override
  void initState() {
    super.initState();
    if (widget.client == null) {
      String newRandomId = generateRandomId();

      setState(() {
        newClient = true;
        widget.client = Client(id: newRandomId, calls: MSimpleList<Call>());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        !newClient ? 'Modificar Cliente' : 'Nuevo Cliente',
        textAlign: TextAlign.center,
      ),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              initialValue: widget?.client?.id ?? '',
              decoration: InputDecoration(labelText: 'ID'),
              readOnly: true,
              enabled: false,
              autovalidateMode: AutovalidateMode.always,
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: widget?.client?.name ?? '',
              decoration: InputDecoration(labelText: 'Nombre'),
              autovalidateMode: AutovalidateMode.always,
              validator: (value) =>
                  value.isEmpty ? 'Este campo es requerido.' : null,
              onChanged: (value) =>
                  setState(() => widget?.client?.name = value),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: widget?.client?.telephoneNumber ?? '',
              decoration: InputDecoration(labelText: 'Número de extension'),
              autovalidateMode: AutovalidateMode.always,
              validator: (value) =>
                  value.isEmpty ? 'Este campo es requerido.' : null,
              onChanged: (value) =>
                  setState(() => widget?.client?.telephoneNumber = value),
            ),
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
      Navigator.pop(context, widget.client);

      String newClientMessage = 'Se ha agregado un nuevo cliente correctamente';
      String updateClientMessage = 'Se ha modificado el cliente correctamente';
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(newClient ? newClientMessage : updateClientMessage)));
    }
  }
}
