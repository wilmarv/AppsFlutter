import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController controleAltura = TextEditingController();
  TextEditingController controlePeso = TextEditingController();
  String _textoInfo = "Informe seus Dados!";
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _limparCampo() {
    setState(() {
      controlePeso.text = "";
      controleAltura.text = "";
      _textoInfo = "Informe seus Dados!";
      _formKey = GlobalKey<FormState>();
    });
  }
  void _calcular() {
    setState(() {
      double peso = double.parse(controlePeso.text);
      double altura = double.parse(controleAltura.text) / 100;
      double imc = peso / (altura * altura);
      if (imc < 18.5) {
        _textoInfo = "Abaixo do Peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 18.5 && imc < 25) {
        _textoInfo = "Peso Ideial (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 25 && imc < 30) {
        _textoInfo = "Sobrepeso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 30 && imc < 35) {
        _textoInfo = "Obesidade Grau I (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 35 && imc < 40) {
        _textoInfo = "Obesidade Grau II (${imc.toStringAsPrecision(3)})";
      } else {
        _textoInfo =
            "Obesidade Grau III ou Mórbida (${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.grey,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed: _limparCampo)
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.person_outline,
                size: 120,
                color: Colors.grey,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Peso em (Kg)",
                    labelStyle: TextStyle(color: Colors.grey)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 25),
                controller: controlePeso,
                // ignore: missing_return
                validator: (value){
                  if(value.isEmpty){
                    return "Insira sua Altura!";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Altura em (Cm)",
                    labelStyle: TextStyle(color: Colors.grey)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 25),
                controller: controleAltura,
                // ignore: missing_return
                validator: (value){
                  if(value.isEmpty){
                    return "Insira sua Altura!";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Container(
                  height: 50,
                  child: RaisedButton(
                    onPressed: (){
                      if(_formKey.currentState.validate()){
                        _calcular();
                      }
                    },
                    child: Text("Calcular",
                        style: TextStyle(color: Colors.white, fontSize: 25)),
                    color: Colors.grey,
                  ),
                ),
              ),
              Text(
                _textoInfo,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 25),
              )
            ],
          )
        )
      ),
    );
  }
}
