import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tellist/screens/NovoContato.dart';

class ListaDeTelefones extends StatefulWidget {
  const ListaDeTelefones({super.key});

  @override
  State<ListaDeTelefones> createState() => _ListaDeTelefonesState();
}

class _ListaDeTelefonesState extends State<ListaDeTelefones> {
  final Stream<QuerySnapshot> contactsStream =
      FirebaseFirestore.instance.collection('contacts').snapshots();
  CollectionReference db = FirebaseFirestore.instance.collection("contacts");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Telefones'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: contactsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  Text('Loading'),
                ],
              ),
            );
          }

          return ListView(
            children: snapshot.data!.docs
                .map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return ListTile(
                    title: Text(data['nome']),
                    subtitle: Text(data['numero']),
                  );
                })
                .toList()
                .cast(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const NovoContato(),
            ),
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
