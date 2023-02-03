import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});


  final FirebaseFirestore firestore = FirebaseFirestore.instance;

   _create(String firstUserName, String lastUserName) async {
    try {
      await firestore.collection('users').doc(firstUserName).set({
        'firstName': firstUserName,
        'lastName': lastUserName,
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _read() async {
    DocumentSnapshot documentSnapshot;
    try {
      documentSnapshot =
          await firestore.collection('users').doc('testUser').get();
      print(documentSnapshot.data);
    } catch (e) {
      print(e);
    }
  }

  void _update() async {
    try {
      firestore.collection('users').doc('testUser').update({
        'firstName': 'Alan',
      });
    } catch (e) {
      print(e);
    }
  }

  void _delete() async {
    try {
      firestore.collection('users').doc('testUser').delete();
    } catch (e) {
      print(e);
    }
  }

  //declare
  final firstusernameController = TextEditingController();

  final lastusernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter CRUD with Firebase"),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: firstusernameController,
              ),
              TextField(
                controller: lastusernameController,
              ),
              ElevatedButton(
                onPressed: () {
                   _create(firstusernameController.text, lastusernameController.text);
                },
                child: const Text("Create"),
              ),
              ElevatedButton(
                onPressed: _read,
                child: const Text("Read"),
              ),
              ElevatedButton(
                onPressed: _update,
                child: const Text("Update"),
              ),
              ElevatedButton(
                onPressed: _delete,
                child: const Text("Delete"),
              ),
            ]),
      ),
    );
  }
}
