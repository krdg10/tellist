import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tellist/firebase_options.dart';

// https://www.youtube.com/watch?v=HA4hPS460YY
// ai ver de salvar algo... carregar algo...
// dps login e as ações de fato.
//https://firebase.google.com/docs/firestore/quickstart?hl=pt-br#dart
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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final db = FirebaseFirestore.instance;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = db.collection("users");

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: users.get(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              List<Map<String, dynamic>?>? users = snapshot.data?.docs
                  .map((e) => e.data() as Map<String, dynamic>?)
                  .toList();
//https://stackoverflow.com/questions/68494359/type-jsonquerysnapshot-is-not-a-subtype-of-type-mapstring-dynamic-in-typ
// https://www.educative.io/answers/how-to-use-flutter-to-read-and-write-data-to-firebase
              if (users!.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.only(top: 80),
                  child: Center(
                    child: Text(
                      "This category doesn't have elements.",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ),
                );
              } else {
                return SizedBox(
                  height: 500,
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: users.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemBuilder: (context, index) {
                      final json = users[index];
                      return Text('$json');
                    },
                  ),
                );
              }
          }

          return Text('Unknowm error');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
