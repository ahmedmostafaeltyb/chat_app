import 'package:cahtapp/helper/show_snack_bar.dart';
import 'package:cahtapp/pages/chat_page.dart';
import 'package:cahtapp/widgets/custom_button.dart';
import 'package:cahtapp/widgets/custom_text_field.dart';
import 'package:cahtapp/widgets/squre_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  String? email;
  String? password;
  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text(
          'chat',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset('assets/images/scholar.png'),
                const Text(
                  'Scholar Chat',
                  style: TextStyle(
                      fontFamily: 'Pacifico',
                      color: Colors.black,
                      fontSize: 28),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'SIGININ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
                CustomTextField(
                  hinttext: 'Email',
                  onchange: (data) {
                    email = data;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  hinttext: 'passsword',
                  onchange: (data) {
                    password = data;
                  },
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      child: Text('forgetpassword?'),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  ontab: () async {
                    if (formkey.currentState!.validate()) {
                      try {
                        await login();
                        showSnackBar(context, 'SUCESSES');
                         Navigator.pushNamed(context, ChatPage.id,arguments: email);
                      } on FirebaseAuthException
                       catch (e) {
                        print(e);
                        if (e.code == 'user-not-found') {
                          showSnackBar(
                              context, 'No user found for that email.');
                        } else if 
                        (e.code == 'wrong-password') {
                          showSnackBar(context,
                              'Wrong password provided for that user.');
                        }
                      }
                    }
                  },
                  title: 'login',
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Colors.amber[200],
                      ),
                    ),
                    const Text('or continue with'),
                    Expanded(
                        child: Divider(
                      thickness: 1,
                      color: Colors.amber[200],
                    ))
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SqureImage(imagepath: 'assets/images/google-symbol.png'),
                    SizedBox(
                      width: 16,
                    ),
                    SqureImage(imagepath: 'assets/images/apple-logo.png'),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Not a member?'),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'Registerpage');
                      },
                      child: const Text(
                        'Regester Now',
                        style: TextStyle(color: Colors.amber),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> login() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
