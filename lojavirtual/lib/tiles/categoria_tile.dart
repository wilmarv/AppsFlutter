import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/screens/categoria_screen.dart';
class CategoriaTile extends StatelessWidget {
  final DocumentSnapshot snapshot;
  CategoriaTile(this.snapshot);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.transparent,
        backgroundImage: snapshot.data["icon"] != "vazio" ?  NetworkImage(snapshot.data["icon"]): null,
      ),
      title: Text(snapshot.data["title"]),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context)=> CategoriaScreen(snapshot))
        );
      },
    );
  }
}
