import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FormContact extends StatelessWidget {
  final String updateOrCreate;
  const FormContact({Key? key, required this.updateOrCreate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controllerNome = TextEditingController();
    final TextEditingController _controllerNumero = TextEditingController();
    CollectionReference contacts =
        FirebaseFirestore.instance.collection("contacts");
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _controllerNome,
            decoration: const InputDecoration(labelText: 'Nome'),
          ),
          TextField(
            keyboardType: const TextInputType.numberWithOptions(),
            controller: _controllerNumero,
            decoration: const InputDecoration(
              labelText: 'Telefone',
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            child: Text('$updateOrCreate'),
            onPressed: () async {
              final String name = _controllerNome.text;
              final String numero = _controllerNumero.text;
              if (updateOrCreate == 'Create') {
                await contacts.add({"nome": name, "numero": numero});
              }
              _controllerNome.text = '';
              _controllerNumero.text = '';
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}
