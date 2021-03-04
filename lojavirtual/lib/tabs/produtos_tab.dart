import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/tiles/categoria_tile.dart';

class ProdutosTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: Firestore.instance
            .collection("produtos")
            .orderBy("pos")
            .getDocuments(),
        // ignore: missing_return
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          else {
            var dividerTiles = ListTile.divideTiles(
                    tiles: snapshot.data.documents.map((doc) {
                      return CategoriaTile(doc);
                    }).toList(),
                    color: Colors.grey[500])
                .toList();
            return ListView(
              children: dividerTiles,
            );
          }
        });
  }
}
