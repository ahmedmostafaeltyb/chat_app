import 'package:cahtapp/firebase_options.dart';
import 'package:cahtapp/pages/auth_screen.dart';
import 'package:cahtapp/pages/chat_page.dart';
import 'package:cahtapp/pages/login_page.dart';
import 'package:cahtapp/pages/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Scholarchat());
}

class Scholarchat extends StatelessWidget {
  const Scholarchat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        'loginpage': (context) => LoginPage(),
        'Registerpage': (context) => RegisterPage(),
        ChatPage.id: (context) => ChatPage()
      },
      home: LoginPage(),
    );
  }
}
