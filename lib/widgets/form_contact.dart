// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class FormContact extends StatefulWidget {
  final String updateOrCreate;
  final String nome;
  final String numero;
  final DocumentSnapshot? document;
  const FormContact(
      {Key? key,
      required this.updateOrCreate,
      this.nome = '',
      this.numero = '',
      this.document})
      : super(key: key);

  @override
  State<FormContact> createState() => _FormContactState();
}

class _FormContactState extends State<FormContact> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var maskFormatter = MaskTextInputFormatter(
        mask: '(##) #####-####',
        filter: {"#": RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy);
    final TextEditingController controllerNome = TextEditingController();
    final TextEditingController controllerNumero = TextEditingController();
    controllerNome.text = widget.nome;
    controllerNumero.text = widget.numero;

    CollectionReference contacts =
        FirebaseFirestore.instance.collection("contacts");
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: controllerNome,
              decoration: const InputDecoration(labelText: 'Nome'),
              inputFormatters: [
                LengthLimitingTextInputFormatter(50),
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Insira nome para o contato';
                }
                return null;
              },
            ),
            TextFormField(
              keyboardType: const TextInputType.numberWithOptions(),
              controller: controllerNumero,
              decoration: const InputDecoration(
                labelText: 'Telefone',
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                maskFormatter
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Insira algum número';
                } else if (value.length != 14 && value.length != 15) {
                  return 'Insira número válido';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              child: Text(widget.updateOrCreate),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  String name = controllerNome.text;
                  final String numero = controllerNumero.text;
                  if (widget.updateOrCreate == 'Create') {
                    await contacts.add({"nome": name, "numero": numero});
                  } else {
                    widget.document!.reference.update(
                        <String, dynamic>{'nome': name, 'numero': numero});
                  }
                  controllerNome.text = '';
                  controllerNumero.text = '';
                  Navigator.of(context).pop();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
