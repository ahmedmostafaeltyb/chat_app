import 'package:cahtapp/pages/chat_page.dart';
import 'package:cahtapp/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshout) {
            if (snapshout.hasData) {
              return ChatPage();
            } else {
              return LoginPage();
            }
          }),
    );
  }
}
