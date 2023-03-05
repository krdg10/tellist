import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tellist/widgets/FormContact.dart';

class NovoContato extends StatelessWidget {
  const NovoContato({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Contato'),
      ),
      body: const FormContact(updateOrCreate: 'Create'),
    );
  }
}
