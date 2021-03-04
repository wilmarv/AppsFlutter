import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/datas/produtos_data.dart';
import 'package:lojavirtual/tiles/produto_tile.dart';

class CategoriaScreen extends StatelessWidget {
  final DocumentSnapshot snapshot;

  CategoriaScreen(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: Text(snapshot.data["title"]),
              centerTitle: true,
              bottom: TabBar(
                indicatorColor: Colors.white,
                tabs: [
                  Tab(icon: Icon(Icons.grid_on)),
                  Tab(icon: Icon(Icons.list)),
                ],
              ),
            ),
            body: FutureBuilder<QuerySnapshot>(
              future: Firestore.instance
                  .collection("produtos")
                  .document(snapshot.documentID)
                  .collection("itens")
                  .getDocuments(),
              // ignore: missing_return
              builder: (context, dados) {
                if (!dados.hasData)
                  return Center(child: CircularProgressIndicator());
                else
                  return TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      GridView.builder(
                        padding: EdgeInsets.all(4),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 4,
                            childAspectRatio: 0.65),
                        itemCount: dados.data.documents.length,
                        // ignore: missing_return
                        itemBuilder: (context, index) {
                          return ProdutoTile(
                              "grid",
                              DataProdutos.fromDocuments(
                                  dados.data.documents[index]));
                        },
                      ),
                      ListView.builder(
                        padding: EdgeInsets.all(4),
                        itemCount: dados.data.documents.length,
                        itemBuilder: (context, index) {
                          return ProdutoTile(
                              "list",
                              DataProdutos.fromDocuments(
                                  dados.data.documents[index]));
                        },
                      )
                    ],
                  );
              },
            )));
  }
}
