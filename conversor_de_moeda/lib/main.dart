import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const linkAPI = "https://economia.awesomeapi.com.br/json/all";

void main() async {
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(
      hintColor: Colors.green,
      primaryColor: Colors.white,
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder:
          OutlineInputBorder(borderSide: BorderSide(color:Colors.green)),
        focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        hintStyle: TextStyle(color: Colors.green)
      )
    ),
  ));
}

Future<Map> getData() async {
  http.Response response = await http.get(linkAPI);
  return jsonDecode(response.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final controladorReal = TextEditingController();
  final controladorDollar = TextEditingController();
  final controladorEuro = TextEditingController();
  double dolar;
  double euro;
  void _apagarCampos(){
    controladorReal.text = "";
    controladorDollar.text = "";
    controladorEuro.text = "";
  }
  void _converterReal(String text){
    if(text.isEmpty){
      _apagarCampos();
      return;
    }
    double real = double.parse(text);
    controladorDollar.text = (real/dolar).toStringAsFixed(2);
    controladorEuro.text = (real/euro).toStringAsFixed(2);
  }
  void _converterDollar(String text){
    if(text.isEmpty){
      _apagarCampos();
      return;
    }
    double dolar = double.parse(text);
    controladorReal.text = (dolar*this.dolar).toStringAsFixed(2);
    controladorEuro.text = (dolar*this.dolar/euro).toStringAsFixed(2);
  }
  void _converterEuro(String text){
    if(text.isEmpty){
      _apagarCampos();
      return;
    }
    double euro = double.parse(text);
    controladorReal.text = (euro*this.euro).toStringAsFixed(2);
    controladorDollar.text= (euro*this.euro/dolar).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("\$ Conversor \$ "),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
          future: getData(),
          // ignore: missing_return
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: Text(
                    "Carregando Dados...!!",
                    style: TextStyle(color: Colors.green, fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                );
              default:
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "Erro ao Carregar Dados!",
                      style: TextStyle(color: Colors.green, fontSize: 25),
                      textAlign: TextAlign.center,
                    ),
                  );
                }
                else{
                  dolar = double.parse(snapshot.data["USD"]["ask"]);
                  euro = double.parse(snapshot.data["EUR"]["ask"]);
                  print(euro);
                  return SingleChildScrollView(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Icon(Icons.monetization_on,size: 150,color: Colors.green,),
                        buildTextFiel("Reais", "R\$",controladorReal,_converterReal),
                        Divider(),
                        buildTextFiel("Dolares", "US\$",controladorDollar,_converterDollar),
                        Divider(),
                        buildTextFiel("Euros", "€\$",controladorEuro,_converterEuro),
                      ],
                    ),
                  );
                }
            }
          }),
    );
  }
}

Widget buildTextFiel(String label,String prefix,TextEditingController controle,Function funcao){
  return TextField(
    controller: controle,
    decoration: InputDecoration(
        labelText:label,
        labelStyle: TextStyle(color: Colors.green),
        prefixText: prefix
    ),
    style: TextStyle(
        color: Colors.green,fontSize: 25
    ),
    onChanged: funcao,
    keyboardType: TextInputType.number,
  );
}
