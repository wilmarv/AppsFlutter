import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lojavirtual/datas/produtos_data.dart';

class CartProduto {
  String cid;

  String categoria;
  String pid;

  int quantidade;
  String tamanho;

  DataProdutos produtoData;

  CartProduto();

  CartProduto.fromDocument(DocumentSnapshot snapshot){
    cid = snapshot.documentID;
    categoria = snapshot.data["categoria"];
    pid = snapshot.data["pid"];
    quantidade = snapshot.data["quantidade"];
    tamanho = snapshot.data["tamanho"];
  }

  Map<String,dynamic>topMap(){
    return {
      "categoria":categoria,
      "pid":pid,
      "quantidade":quantidade,
      "tamanho":tamanho,
      /*"produto": produtoData.toResumedMap()*/
    };
  }

}