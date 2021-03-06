import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lojavirtual/datas/cart_produto.dart';
import 'package:lojavirtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';

class CartModel extends Model{

  UserModel user;

  List<CartProduto> produtos = [];
  CartModel(this.user);
  static CartModel of(BuildContext context)=> ScopedModel.of<CartModel>(context);

  void addCartItem(CartProduto cartProduto){
    produtos.add(cartProduto);
    Firestore.instance.collection("users").document(user.user.uid)
    .collection("cart").add(cartProduto.topMap()).then((value) {
      cartProduto.cid = value.documentID;
    });
    notifyListeners();
  }
  void removeCartItem(CartProduto cartProduto){
    Firestore.instance.collection("users").document(user.user.uid)
        .collection("cart").document(cartProduto.cid).delete();
    produtos.remove(cartProduto);
    notifyListeners();
  }

}