import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
void main(){
  runApp(MaterialApp(
    home: Container(),
  ));
  Firestore.instance.collection("mensagem").document('msg1').setData({
    "texto": "Olá",
    "from": "Wilmar",
    "read": false
  });
}