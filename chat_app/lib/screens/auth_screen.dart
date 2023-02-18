import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isloading = false;
  void _submitAuthForm(String email, String username, String password,
      bool isLogin, BuildContext ctx) async {
    UserCredential userCredential;
    try {
      setState(() {
        _isloading = true;
      });
      if (isLogin) {
        userCredential = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        userCredential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user?.uid)
            .set({
          'username': username,
          'email': email,
        });
      }
    } on PlatformException catch (e) {
      var msg = 'an error occured';
      if (e.message != null) {
        msg = e.message!;
      }
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: Text(msg),
        backgroundColor: Theme.of(ctx).errorColor,
      ));
      setState(() {
        _isloading = false;
      });
    } catch (err) {
      print(err);
      setState(() {
        _isloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(
        _submitAuthForm,
        _isloading,
      ),
    );
  }
}
