import 'package:cahtapp/model/message.dart';
import 'package:cahtapp/widgets/message_bubles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChatPage extends StatefulWidget {
  ChatPage({super.key});
  static String id = 'chatpage';

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _controllers = ScrollController();
  TextEditingController _controller = TextEditingController();

  CollectionReference message =
      FirebaseFirestore.instance.collection('messages');

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: message.orderBy('crateAt').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messagelist = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagelist.add(Message.fromJson(snapshot.data!.docs[i]));
          }

          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.logout),
                )
              ],
              automaticallyImplyLeading: false,
              backgroundColor: Colors.yellow.shade100,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/scholar.png',
                    height: 50,
                  ),
                  Text('chat')
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      //reverse: true,
                      controller: _controllers,
                      itemCount: messagelist.length,
                      itemBuilder: (context, index) {
                        return messagelist[index].id == email
                            ? MessageBubles(
                                message: messagelist[index],
                              )
                            : ChatBubleForFriend(message: messagelist[index]);
                      }),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onSubmitted: (data) {
                        message.add({
                          'message': data,
                          'crateAt': DateTime.now(),
                          'id': email
                        });
                        _controller.clear();
                        _controllers.animateTo(
                            _controllers.position.maxScrollExtent,
                            duration: Duration(seconds: 1),
                            curve: Curves.fastOutSlowIn);
                      },
                      controller: _controller,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.amber),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.amber),
                          ),
                          suffixIcon: Icon(Icons.send)),
                    )),
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
