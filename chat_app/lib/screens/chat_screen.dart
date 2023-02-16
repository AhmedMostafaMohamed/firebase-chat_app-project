import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  final ins = FirebaseFirestore.instance;
  ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (contex, index) => Container(
                padding: EdgeInsets.all(8.0),
                child: Text('this works!'),
              )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (() {
          ins
              .collection('chats/G70r5r6DoEM8PjkHHNCI/messages')
              .snapshots()
              .listen((event) {
            print(event);
          });
        }),
      ),
    );
  }
}
