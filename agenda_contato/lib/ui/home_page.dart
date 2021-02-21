import 'dart:io';

import 'package:agenda_contato/helpers/contato_helper.dart';
import 'package:agenda_contato/ui/contact_page.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
enum Ordernador{orderaz,orderza}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContactHelper helper = ContactHelper();
  List<Contact> contatos = List();

  @override
  void initState() {
    super.initState();
    _pegarContatos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contatos"),
        backgroundColor: Colors.red,
        centerTitle: true,
        actions: [
          PopupMenuButton<Ordernador>(
            itemBuilder: (context)=> <PopupMenuEntry<Ordernador>>[
              const PopupMenuItem<Ordernador>(
                child: Text("Ordernar de A-Z"),
                value: Ordernador.orderaz,
              ),
              const PopupMenuItem<Ordernador>(
                child: Text("Ordernar de Z-A"),
                value: Ordernador.orderza,
              )
            ],
            onSelected: _ordenarList,
          )
        ],
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _mostrarPaginaContato();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: contatos.length,
          // ignore: missing_return
          itemBuilder: (context, index) {
            return _contactCard(context, index);
          }),
    );
  }

  Widget _contactCard(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: contatos[index].img != null
                          ? FileImage(File(contatos[index].img))
                          : AssetImage("image/person.png")),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contatos[index].nome ?? "",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(contatos[index].email ?? "",
                        style: TextStyle(fontSize: 14)),
                    Text(contatos[index].tel ?? "",
                        style: TextStyle(fontSize: 15))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () {
        _mostrarOpcao(context, index);
      },
    );
  }

  void _mostrarOpcao(BuildContext context, int index) {
    showBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
            onClosing: () {},
            builder: (context) {
              return Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: FlatButton(
                          onPressed: () {
                            launch("tel:${contatos[index].tel}");
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Ligar",
                            style: TextStyle(color: Colors.red, fontSize: 20),
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _mostrarPaginaContato(contato: contatos[index]);
                          },
                          child: Text(
                            "Editar",
                            style: TextStyle(color: Colors.red, fontSize: 20),
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: FlatButton(
                          onPressed: () {
                            helper.deleteContact(contatos[index].id);
                            setState(() {
                              contatos.removeAt(index);
                              Navigator.pop(context);
                            });
                          },
                          child: Text(
                            "Excluir",
                            style: TextStyle(color: Colors.red, fontSize: 20),
                          )),
                    )
                  ],
                ),
              );
            },
          );
        });
  }

  void _mostrarPaginaContato({Contact contato}) async {
    final gravarContato = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ContactPage(
                  contato: contato,
                )));
    if (gravarContato != null) {
      if (contato != null)
        await helper.updateContact(gravarContato);
      else
        await helper.saveContact(gravarContato);
      _pegarContatos();
    }
  }

  void _pegarContatos() {
    helper.getall().then((list) {
      setState(() {
        contatos = list;
      });
    });
  }

  void _ordenarList(Ordernador resultado){
    switch(resultado){
      case Ordernador.orderaz:
        contatos.sort((a,b){
          return a.nome.toLowerCase().compareTo(b.nome.toLowerCase());
        });
        break;
      case Ordernador.orderza:
        contatos.sort((a,b){
          return b.nome.toLowerCase().compareTo(a.nome.toLowerCase());
        });
        break;
    }
    setState(() {

    });
  }
}
