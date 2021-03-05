import 'package:cloud_firestore/cloud_firestore.dart';

class DataProdutos{

  String categoria;
  String id;

  String title;
  String descricao;

  double preco;

  List images;
  List sizes;

  DataProdutos.fromDocuments(DocumentSnapshot snapshot){
    id = snapshot.documentID;
    title = snapshot.data["title"];
    descricao = snapshot.data["descrição"];
    preco = snapshot.data["preço"] + 0.0;
    images = snapshot.data["image"];
    sizes = snapshot.data["tamanho"];
  }
  Map<String,dynamic>toResumedMap(){
    return {
      "title": title,
      "descrição": descricao,
      "preço": preco
    };
  }

}