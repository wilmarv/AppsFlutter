import 'dart:io';

import 'package:agenda_contato/helpers/contato_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ContactPage extends StatefulWidget {
  final Contact contato;

  ContactPage({this.contato});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _controladorNome = TextEditingController();
  final _controladorEmail = TextEditingController();
  final _controladorTel = TextEditingController();
  final _nomeFocus = FocusNode();
  bool _editarUsuario = false;
  Contact _editarContato;

  @override
  void initState() {
    super.initState();
    if (widget.contato == null) {
      _editarContato = Contact();
    } else {
      _editarContato = Contact.fromMap(widget.contato.toMap());
      _controladorNome.text = _editarContato.nome;
      _controladorEmail.text = _editarContato.email;
      _controladorTel.text = _editarContato.tel;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text(_editarContato.nome ?? "Novo Contato"),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (_editarContato.nome != null && _editarContato.nome.isNotEmpty) {
              Navigator.pop(context, _editarContato);
            } else {
              FocusScope.of(context).requestFocus(_nomeFocus);
            }
          },
          child: Icon(Icons.save),
          backgroundColor: Colors.red,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              GestureDetector(
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: _editarContato.img != null
                            ? FileImage(File(_editarContato.img))
                            : AssetImage("image/person.png")),
                  ),
                ),
                onTap: (){
                  ImagePicker.pickImage(source: ImageSource.gallery).then((file){
                    if(file == null)return;
                    setState(() {
                      _editarContato.img = file.path;
                    });
                  });
                },
              ),
              TextField(
                controller: _controladorNome,
                focusNode: _nomeFocus,
                decoration: InputDecoration(labelText: "Nome"),
                onChanged: (text) {
                  _editarUsuario = true;
                  setState(() {
                    _editarContato.nome = text;
                  });
                },
              ),
              TextField(
                controller: _controladorEmail,
                decoration: InputDecoration(labelText: "Email"),
                onChanged: (text) {
                  _editarUsuario = true;
                  _editarContato.email = text;
                },
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                controller: _controladorTel,
                decoration: InputDecoration(labelText: "Telefone"),
                onChanged: (text) {
                  _editarUsuario = true;
                  _editarContato.tel = text;
                },
                keyboardType: TextInputType.phone,
              )
            ],
          ),
        ),
      ),
    );
  }
  Future<bool> _requestPop(){
    if(_editarUsuario){
      showDialog(context: context,
          builder: (context){
            return AlertDialog(
              title: Text("Descartar Alterações?"),
              content: Text("Se sair as alterações serão perdidas."),
              actions: [
                FlatButton(onPressed: (){Navigator.pop(context);}, child: Text("Cancelar")),
                FlatButton(onPressed: (){Navigator.pop(context);Navigator.pop(context);},
                    child: Text("Descartar!"))
              ],
            );
          }
      );
      return Future.value(false);
    }
    else{
      return Future.value(true);
    }
  }
}

