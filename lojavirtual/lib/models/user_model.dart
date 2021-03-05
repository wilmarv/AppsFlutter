import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';

class UserModel extends Model {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;
  Map<String, dynamic> userData = Map();

  bool isLoading = false;

  void singUp (
      {@required Map<String, dynamic> userData,
      @required String pass,
      @required VoidCallback onSuccess,
      @required VoidCallback onFail}) {
    isLoading = true;
    notifyListeners();
    _auth
        .createUserWithEmailAndPassword(
            email: userData["email"], password: pass)
        .then((user)async {

      this.user = user;
      onSuccess();

      await _saveUserData(userData);

      isLoading = false;
      notifyListeners();
    }).catchError((e) {
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  void singIn() async {
    isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 3));
    isLoading = false;
    notifyListeners();
  }

  void recoverPass() {}

  void isLoggerIn() {}

  Future _saveUserData(Map<String,dynamic> userData)async{
    this.userData = userData;
    await Firestore.instance.collection("users").document(user.uid).setData(userData);
  }
}

