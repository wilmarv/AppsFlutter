import 'package:flutter/material.dart';
import 'package:lojavirtual/models/user_model.dart';
import 'package:lojavirtual/screens/cadastro_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatelessWidget {
  final _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Entrar"),
        centerTitle: true,
        actions: [
          FlatButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => CadastroScreen()));
              },
              child: Text(
                "CRIAR CONTA",
                style: TextStyle(fontSize: 15, color: Colors.white),
              ))
        ],
      ),
      body: ScopedModelDescendant<UserModel>(
        // ignore: missing_return
        builder: (context, child, model) {
          if(model.isLoading)
            return Center(
              child: CircularProgressIndicator(),
            );
          return Form(
            key: _globalKey,
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(hintText: "E-mail"),
                  // ignore: missing_return
                  validator: (text) {
                    if (text.isEmpty || !text.contains("@"))
                      return "E-mail inválido!";
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    hintText: "Senha",
                  ),
                  obscureText: true,
                  // ignore: missing_return
                  validator: (text) {
                    if (text.isEmpty || text.length < 6)
                      return "Senha Inválida!";
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () {},
                    child: Text(
                      "Esqueci minha senha",
                      textAlign: TextAlign.right,
                    ),
                    padding: EdgeInsets.zero,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 44,
                  child: RaisedButton(
                    onPressed: () {
                      if (_globalKey.currentState.validate()) {

                      }
                      model.singIn();
                    },
                    child: Text(
                      "Entrar",
                      style: TextStyle(fontSize: 18),
                    ),
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
