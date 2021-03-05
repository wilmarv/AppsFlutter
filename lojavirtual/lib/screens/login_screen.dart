import 'package:flutter/material.dart';

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
              onPressed: () {},
              child: Text(
                "CRIAR CONTA",
                style: TextStyle(fontSize: 15, color: Colors.white),
              ))
        ],
      ),
      body: Form(
        key: _globalKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(hintText: "E-mail"),
              // ignore: missing_return
              validator: (text){
                if(text.isEmpty || !text.contains("@")) return "E-mail inválido!";
              },
            ),
            SizedBox(height: 6),
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
                  if(_globalKey.currentState.validate()){
                    
                  }
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
      ),
    );
  }
}
