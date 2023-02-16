import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chats/PdA7M9g4gpDsGjlIWK82/messages')
            .snapshots(),
        builder: (ctx, StreamSnapshot) {
          if (StreamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final documents = StreamSnapshot.data?.docs;
          return ListView.builder(
              itemCount: documents?.length,
              itemBuilder: (contex, index) => Container(
                    padding: EdgeInsets.all(8.0),
                    child: Text(documents![index]['text']),
                  ));
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (() {
          FirebaseFirestore.instance
              .collection('chats/PdA7M9g4gpDsGjlIWK82/messages')
              .add(
                  {'text': 'this is an added message by clicking the button!'});
        }),
      ),
    );
  }
}
