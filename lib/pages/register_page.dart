import 'package:cahtapp/helper/show_snack_bar.dart';
import 'package:cahtapp/pages/chat_page.dart';
import 'package:cahtapp/widgets/custom_button.dart';
import 'package:cahtapp/widgets/custom_text_field.dart';
import 'package:cahtapp/widgets/squre_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  String? email;
  String? password;
  String? confirmpassword;
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
                    ' REGISTER',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
                CustomTextField(
                  hinttext: 'email',
                  onchange: (data) {
                    email = data;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  hinttext: 'password',
                  onchange: (data) {
                    password = data;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  hinttext: 'confirmpassword',
                  onchange: (data) {
                    confirmpassword = password;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  ontab: () async {
                    if (formkey.currentState!.validate()) {
                      try {
                        await registerMethod();
                        Navigator.pushNamed(context, ChatPage.id);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password' &&
                            password == confirmpassword) {
                          showSnackBar(
                              context, 'The password is not matching.');
                        } else if (e.code == 'email-already-in-use') {
                          showSnackBar(context,
                              'The account already exists for that email.');
                        }
                      } catch (e) {
                        showSnackBar(context, 'The account Success.');
                      }
                    }
                  },
                  title: 'Register',
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
                    const Text('AlreadyHaveanAcount?'),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'LOGIN Now',
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

  Future<void> registerMethod() async {
    var auth = FirebaseAuth.instance;
    UserCredential user = await auth.createUserWithEmailAndPassword(
        email: email!, password: password!);
  }
}
