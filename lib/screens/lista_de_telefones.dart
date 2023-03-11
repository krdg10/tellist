import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tellist/screens/create_or_update_contact.dart';

// essa lista de telefones eu botar um botão pra editar e reaproveitar o formcontact. botao na direita do listtile
// um botão pra apagar também
// colocar um fundinho, uma borda, que seja, na listtile
// paginação
// validação de dados nos edits e creates.
// fazer login. e ai fazer bem pessoal mesmo

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
        //futurebuilder com switch
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
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CreateOrUpdateContact(
                              type: 'Update',
                              nome: data['nome'],
                              numero: data['numero'],
                              document: document),
                        ),
                      );
                    },
                    child: ListTile(
                      title: Text(data['nome']),
                      subtitle: Row(
                        children: [
                          Text(data['numero']),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              db.doc(document.id).delete();
                            },
                            child: const Text('Delete'),
                          ),
                        ],
                      ),
                    ),
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
              builder: (context) => const CreateOrUpdateContact(
                type: 'Create',
              ),
            ),
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
