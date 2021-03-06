import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';

class UserModel extends Model {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;
  Map<String, dynamic> userData = Map();

  bool isLoading = false;

  static UserModel of(BuildContext context) => 
      ScopedModel.of<UserModel>(context);


  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    _loadCurrentUser();
  }

  void singUp(
      {@required Map<String, dynamic> userData,
      @required String pass,
      @required VoidCallback onSuccess,
      @required VoidCallback onFail}) {
    isLoading = true;
    notifyListeners();
    _auth
        .createUserWithEmailAndPassword(
            email: userData["email"], password: pass)
        .then((user) async {
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

  void singIn(
      {@required String email,
      @required String pass,
      @required VoidCallback onSuccess,
      @required VoidCallback onFail}) async {
    isLoading = true;
    notifyListeners();

    _auth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((value)async {
          this.user=value;
          await _loadCurrentUser();
          onSuccess();
          notifyListeners();
    })
        .catchError((onError) {
          onFail();
          isLoading = false;
          notifyListeners();
    });
  }

  void recoverPass(String email) {
    _auth.sendPasswordResetEmail(email: email);
  }

  void singOut() async {
    await _auth.signOut();
    userData = Map();
    user = null;
    notifyListeners();
  }

  bool isLoggerIn() {
    return user != null;
  }

  Future _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;
    await Firestore.instance
        .collection("users")
        .document(user.uid)
        .setData(userData);
  }
  Future _loadCurrentUser()async{
    if(user==null)
      user = await _auth.currentUser();
    if(user!=null){
      if(userData["nome"]==null) {
        DocumentSnapshot docUser = await Firestore.instance
            .collection("users")
            .document(user.uid)
            .get();
        userData = docUser.data;
      }
      notifyListeners();
    }

  }
}
