import 'package:flutter/material.dart';
import 'package:lojavirtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CadastroScreen extends StatefulWidget {
  @override
  _CadastroScreenState createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _adressController = TextEditingController();

  final _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Criar Conta"),
          centerTitle: true,
        ),
        body: ScopedModelDescendant<UserModel>(
          // ignore: missing_return
          builder: (context, child, model) {
            if (model.isLoading)
              return Center(
                child: CircularProgressIndicator(),
              );
            return Form(
              key: _globalKey,
              child: ListView(
                padding: EdgeInsets.all(16),
                children: [
                  TextFormField(
                    controller: _nameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(hintText: "Nome Completo"),
                    // ignore: missing_return
                    validator: (text) {
                      if (text.isEmpty) return "Nome inválido!";
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
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
                    controller: _passController,
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
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _adressController,
                    keyboardType: TextInputType.streetAddress,
                    decoration: InputDecoration(hintText: "Endereço"),
                    // ignore: missing_return
                    validator: (text) {
                      if (text.isEmpty) return "Endereço inválido!";
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 44,
                    child: RaisedButton(
                      onPressed: () {
                        if (_globalKey.currentState.validate()) {
                          Map<String, dynamic> _userData = {
                            "nome": _nameController.text,
                            "email": _emailController.text,
                            "adress": _adressController.text
                          };
                          model.singUp(
                              userData: _userData,
                              pass: _passController.text,
                              onSuccess: _onSuccess,
                              onFail: _onFail);
                        }
                      },
                      child: Text(
                        "Criar Conta",
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
        ));
  }
  void _onSuccess() {}

  void _onFail() {}
}
