import 'package:call_center/src/core/models/Agent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddAgentDialog extends StatefulWidget {
  Agent agent;
  AddAgentDialog({Key key, this.agent}) : super(key: key);

  @override
  _AddAgentDialogState createState() => _AddAgentDialogState();
}

class _AddAgentDialogState extends State<AddAgentDialog> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.agent == null) {
      setState(() => widget.agent = Agent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.agent != null ? 'Modificar Agente' : 'Nuevo Agente',
        textAlign: TextAlign.center,
      ),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              initialValue: widget?.agent?.id ?? '',
              decoration: InputDecoration(labelText: 'ID'),
              autovalidateMode: AutovalidateMode.always,
              validator: (value) =>
                  value.isEmpty ? 'Este campo es requerido.' : null,
              onChanged: (value) => setState(() => widget?.agent?.id = value),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: widget?.agent?.name ?? '',
              decoration: InputDecoration(labelText: 'Nombre'),
              autovalidateMode: AutovalidateMode.always,
              validator: (value) =>
                  value.isEmpty ? 'Este campo es requerido.' : null,
              onChanged: (value) => setState(() => widget?.agent?.name = value),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: widget?.agent?.extensionNumber ?? '',
              decoration: InputDecoration(labelText: 'Número de extension'),
              autovalidateMode: AutovalidateMode.always,
              validator: (value) =>
                  value.isEmpty ? 'Este campo es requerido.' : null,
              onChanged: (value) =>
                  setState(() => widget?.agent?.extensionNumber = value),
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
      Navigator.pop(context, widget.agent);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Se ha agregado un nuevo agente.')));
    }
  }
}
