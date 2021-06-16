import 'dart:io';

import 'package:call_center/src/core/enum/AgentSpecialty.dart';
import 'package:call_center/src/core/models/Agent.dart';
import 'package:call_center/src/core/models/Client.dart';
import 'package:call_center/src/core/structures/MSimpleList.dart';
import 'package:call_center/src/core/utils.dart';
import 'package:call_center/src/core/values.dart';
import 'package:call_center/src/providers/DiskProvider.dart';
import 'package:file_selector/file_selector.dart';

import 'package:flutter/material.dart';

class AddAgentDialog extends StatefulWidget {
  Agent agent;
  AddAgentDialog({Key key, this.agent}) : super(key: key);

  @override
  _AddAgentDialogState createState() => _AddAgentDialogState();
}

class _AddAgentDialogState extends State<AddAgentDialog> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool newAgent = false;
  @override
  void initState() {
    String newRandomId = generateRandomId();
    if (widget.agent == null) {
      setState(() {
        newAgent = true;
        widget.agent = Agent(id: newRandomId, clients: MSimpleList<Client>());
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        !newAgent ? 'Modificar Agente' : 'Nuevo Agente',
        textAlign: TextAlign.center,
      ),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: CircleAvatar(
                backgroundColor: Colors.black,
                maxRadius: 48,
                backgroundImage: widget.agent?.image?.isNotEmpty ?? false
                    ? Image.file(File(widget.agent.image)).image
                    : null,
                child: IconButton(
                  icon: Icon(Icons.image_search_rounded,
                      color: widget.agent?.image?.isNotEmpty ?? false
                          ? Colors.transparent
                          : ColorHelper.iconColor),
                  onPressed: _onUpdateImage,
                ),
              ),
            ),
            TextFormField(
              initialValue: widget?.agent?.id ?? '',
              readOnly: true,
              enabled: false,
              decoration: InputDecoration(labelText: 'ID'),
              autovalidateMode: AutovalidateMode.always,
              validator: (value) =>
                  value.isEmpty ? 'Este campo es requerido' : null,
              onChanged: (value) => setState(() => widget?.agent?.id = value),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: widget?.agent?.name ?? '',
              decoration: InputDecoration(labelText: 'Nombre'),
              autovalidateMode: AutovalidateMode.always,
              validator: (value) =>
                  value.isEmpty ? 'Este campo es requerido' : null,
              onChanged: (value) => setState(() => widget?.agent?.name = value),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField(
                value: widget?.agent?.speciality ?? AgentSpeciality.NO_SELECTED,
                autovalidateMode: AutovalidateMode.always,
                decoration: InputDecoration(labelText: 'Especialidad'),
                validator: (value) =>
                    value == null ? 'Este campo es requerido' : null,
                onChanged: (value) =>
                    setState(() => widget?.agent?.speciality = value),
                items: [
                  DropdownMenuItem<AgentSpeciality>(
                      child: Text(
                          agentSpecialityToString(AgentSpeciality.DESKTOPS)),
                      value: AgentSpeciality.DESKTOPS),
                  DropdownMenuItem<AgentSpeciality>(
                      child: Text(
                          agentSpecialityToString(AgentSpeciality.PRINTERS)),
                      value: AgentSpeciality.PRINTERS),
                  DropdownMenuItem<AgentSpeciality>(
                      child: Text(
                          agentSpecialityToString(AgentSpeciality.LAPTOPS)),
                      value: AgentSpeciality.LAPTOPS),
                  DropdownMenuItem<AgentSpeciality>(
                      child: Text(agentSpecialityToString(
                          AgentSpeciality.COMPUTER_NETWORKS)),
                      value: AgentSpeciality.COMPUTER_NETWORKS),
                  DropdownMenuItem<AgentSpeciality>(
                      child: Text(
                          agentSpecialityToString(AgentSpeciality.SERVERS)),
                      value: AgentSpeciality.SERVERS),
                  DropdownMenuItem<AgentSpeciality>(
                      child: Text("NO SELECCIONADO"),
                      value: AgentSpeciality.NO_SELECTED),
                ]),
            SizedBox(height: 16),
            TextFormField(
              initialValue: widget?.agent?.extensionNumber ?? '',
              decoration: InputDecoration(labelText: 'Número de extension'),
              autovalidateMode: AutovalidateMode.always,
              validator: (value) =>
                  value.isEmpty ? 'Este campo es requerido' : null,
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

  void _onUpdateImage() async {
    final typeGroup = XTypeGroup(label: 'images', extensions: ['jpg', 'png']);
    final file = await openFile(acceptedTypeGroups: [typeGroup]);

    if (file != null)
      setState(() {
        widget.agent.image = file.path;
      });
  }

  _onSave(context) async {
    FirebaseProvider diskProvider = FirebaseProvider();
    if (formKey.currentState.validate()) {
      formKey.currentState.save();

      if (widget?.agent?.image?.isNotEmpty ?? false) {
        String newImagePath = await diskProvider.saveImageAgent(
            widget.agent.id, widget.agent.image);
        setState(() {
          widget.agent.image = newImagePath;
        });
      }

      Navigator.pop(context, widget.agent);

      String newAgentMessage = 'Se ha agregado un nuevo agente correctamente';
      String updateAgentMessage = 'Se ha modificado el agente correctamente';
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(newAgent ? newAgentMessage : updateAgentMessage)));
    }
  }
}
