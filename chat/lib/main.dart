import 'chat_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(MaterialApp(
      home: ChatScreen(),
    theme: ThemeData(
      primarySwatch:Colors.blue,
      iconTheme: IconThemeData(
        color: Colors.blue
      )
    ),
  ));
}
