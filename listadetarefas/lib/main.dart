import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

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
  List _toDoList = [];
  final campo = TextEditingController();
  Map<String, dynamic> _lastRemoved;
  int _lastRemovedPos;

  @override
  void initState() {
    super.initState();
    _read().then((data) {
      setState(() {
        _toDoList = json.decode(data);
      });
    });
  }

  void _addToDo() {
    setState(() {
      Map<String, dynamic> newToDo = Map();
      newToDo["title"] = campo.text;
      campo.text = "";
      newToDo["ok"] = false;
      _toDoList.add(newToDo);
      _save();
    });
  }
  Future<Null> _atualizar()async{
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _toDoList.sort((a,b){
        if(a["ok"] && !b["ok"])return  1;
        else if(!a["ok"] && b["ok"])return -1;
        else return 0;
      });
      _save();
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Tarefas"),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(17, 1, 7, 1),
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                  decoration: InputDecoration(
                      labelText: "Nova Tarefa",
                      labelStyle: TextStyle(color: Colors.blueGrey)),
                  controller: campo,
                )),
                RaisedButton(
                    color: Colors.blueGrey,
                    child: Text("ADD"),
                    textColor: Colors.white,
                    onPressed: _addToDo)
              ],
            ),
          ),
          Expanded(
              child: RefreshIndicator(
            onRefresh: _atualizar,
            child: ListView.builder(
                padding: EdgeInsets.only(top: 10),
                itemCount: _toDoList.length,
                // ignore: missing_return
                itemBuilder: buildItem),
          ))
        ],
      ),
    );
  }

  Widget buildItem(context, index) {
    return Dismissible(
      background: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment(-0.9, 0),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
      direction: DismissDirection.startToEnd,
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      child: CheckboxListTile(
        title: Text(_toDoList[index]["title"]),
        value: _toDoList[index]["ok"],
        secondary: CircleAvatar(
          child: Icon(_toDoList[index]["ok"] ? Icons.check : Icons.error),
        ),
        onChanged: (check) {
          setState(() {
            _toDoList[index]["ok"] = check;
            _save();
          });
        },
      ),
      onDismissed: (direction) {
        setState(() {
          _lastRemoved = Map.from(_toDoList[index]);
          _lastRemovedPos = index;
          _toDoList.removeAt(index);
          _save();
          final snack = SnackBar(
            content: Text("Tarefa \"${_lastRemoved["title"]}\" removida!"),
            action: SnackBarAction(
                label: "Desfazer",
                onPressed: () {
                  setState(() {
                    _toDoList.insert(_lastRemovedPos, _lastRemoved);
                    _save();
                  });
                }),
            duration: Duration(seconds: 2),
          );
          Scaffold.of(context).removeCurrentSnackBar();
          Scaffold.of(context).showSnackBar(snack);
        });
      },
    );
  }

  Future<File> _getFile() async {
    final diretorio = await getApplicationDocumentsDirectory();
    return File("${diretorio.path}/data.json");
  }

  Future<File> _save() async {
    String data = json.encode(_toDoList);
    final file = await _getFile();
    return file.writeAsString(data);
  }

  Future<String> _read() async {
    try {
      final file = await _getFile();
      return file.readAsString();
    } catch (e) {
      return null;
    }
  }
}
