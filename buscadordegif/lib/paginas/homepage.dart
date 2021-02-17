import 'dart:convert';

import 'package:buscadordegif/paginas/gif.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';
import 'package:transparent_image/transparent_image.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _pesquisa;
  int _offset = 0;

  Future<Map> _getGif() async {
    http.Response response;
    if (_pesquisa == null || _pesquisa.isEmpty) {
      response = await http.get(
          "https://api.giphy.com/v1/gifs/trending?api_key=3p823HPoHhuczpgGfefDIsp3QGwhGFCM&limit=20&rating=g");
    } else
      response = await http.get(
          "https://api.giphy.com/v1/gifs/search?api_key=3p823HPoHhuczpgGfefDIsp3QGwhGFCM&q=$_pesquisa&limit=19&offset=$_offset&rating=g&lang=en");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.network(
            "https://developers.giphy.com/static/img/dev-logo-lg.7404c00322a8.gif"),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                decoration: InputDecoration(
                    labelText: "Pesquise aqui!",
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder()),
                style: TextStyle(color: Colors.white, fontSize: 18),
                textAlign: TextAlign.center,
                onSubmitted: (text) {
                  setState(() {
                    _pesquisa = text;
                    _offset = 0;
                  });
                },
              )),
          Expanded(
              child: FutureBuilder(
            future: _getGif(),
            // ignore: missing_return
            builder: (contex, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.none:
                  return Container(
                    width: 200,
                    height: 200,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      strokeWidth: 5,
                    ),
                  );
                default:
                  if (snapshot.hasError)
                    return Container();
                  else
                    return _tabeladegif(contex, snapshot);
              }
            },
          ))
        ],
      ),
    );
  }

  int _getCoutn(List data) {
    if (_pesquisa == null) {
      return data.length;
    } else
      return data.length + 1;
  }

  Widget _tabeladegif(BuildContext context, AsyncSnapshot snapshot) {
    return GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
        itemCount: _getCoutn(snapshot.data["data"]),
        // ignore: missing_return
        itemBuilder: (context, index) {
          if (_pesquisa == null || index < snapshot.data["data"].length)
            return GestureDetector(
              child: FadeInImage.memoryNetwork(placeholder: kTransparentImage,
                   image: snapshot.data["data"][index]["images"]["fixed_height"]["url"],
              height: 300,
              fit: BoxFit.cover),
              onTap: (){
                Navigator.push(context,
                MaterialPageRoute(
                  builder: (context) => GifPage(snapshot.data["data"][index])
                ));
              },
              onLongPress: (){
                Share.share(snapshot.data["data"][index]["images"]["fixed_height"]["url"]);
              },
            );
          else
            return Container(
              child: GestureDetector(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 70,
                    ),
                    Text(
                      "Carregar mais...",
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    )
                  ],
                ),
                onTap: (){
                  setState(() {
                    _offset+=19;
                  });
                },
              ),
            );
        });
  }
}
