import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tellist/widgets/form_contact.dart';

class CreateOrUpdateContact extends StatelessWidget {
  final String type;
  final String nome;
  final String numero;
  final DocumentSnapshot? document;

  const CreateOrUpdateContact(
      {Key? key,
      required this.type,
      this.nome = '',
      this.numero = '',
      this.document})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String titulo = 'Novo Contato';
    if (type == 'Update') {
      titulo = 'Editar Contato';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(titulo),
      ),
      body: FormContact(
        updateOrCreate: type,
        nome: nome,
        numero: numero,
        document: document,
      ),
    );
  }
}
