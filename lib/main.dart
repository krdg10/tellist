import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tellist/firebase_options.dart';
import 'package:tellist/screens/lista_de_telefones.dart';

// https://www.youtube.com/watch?v=HA4hPS460YY
// ai ver de salvar algo... carregar algo...
// dps login e as ações de fato.
//https://firebase.google.com/docs/firestore/quickstart?hl=pt-br#dart
// proximos passo: confirmação do delete, design, paginação, adicionar splash page, adicionar um botão pra ligar
// apesar da enrolação do dia... fiz o delete e fiz a mascara la. podia ser melhor mas podia ser pior pelo que pasrecia
// começou a dar um erro pra buildar dps que coloquei essas fitas e que mudei o valor no build.grade.
// Resolver isso
//// enfim... primeiro crud flutter firebase e ai ver como agir. e dps fazer o projeto que quero. Login e o cara fazer a propria lista telefonica com nome e telefone
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ListaDeTelefones(),
    );
  }
}
