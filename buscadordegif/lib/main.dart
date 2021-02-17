import 'package:flutter/material.dart';
import 'paginas/homepage.dart';

void main() {
  runApp(MaterialApp(
      home: HomePage(),
      theme: ThemeData(
          hintColor: Colors.white,
          primaryColor: Colors.black,
          inputDecorationTheme: InputDecorationTheme(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white))))));
}
