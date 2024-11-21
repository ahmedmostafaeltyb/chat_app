import 'package:flutter/foundation.dart';

class Message {
  final String id;
  final String message;

  Message(this.id,this.message);

  factory Message.fromJson(jsonData) {
    return Message(jsonData['message'],jsonData['id']);
  }
}
