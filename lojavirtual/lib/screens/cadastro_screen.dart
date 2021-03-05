import 'package:flutter/material.dart';

class CadastroScreen extends StatelessWidget {
  final _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Criar Conta"),
        centerTitle: true,
      ),
      body: Form(
        key: _globalKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(hintText: "Nome Completo"),
              // ignore: missing_return
              validator: (text){
                if(text.isEmpty) return "Nome inválido!";
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(hintText: "E-mail"),
              // ignore: missing_return
              validator: (text){
                if(text.isEmpty || !text.contains("@")) return "E-mail inválido!";
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
              validator: (text){
                if(text.isEmpty || text.length < 6) return "Senha Inválida!";
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              keyboardType: TextInputType.streetAddress,
              decoration: InputDecoration(hintText: "Endereço"),
              // ignore: missing_return
              validator: (text){
                if(text.isEmpty ) return "Endereço inválido!";
              },
            ),
            SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 44,
              child: RaisedButton(
                onPressed: () {
                  if(_globalKey.currentState.validate()){

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
      ),
    );
  }
}
