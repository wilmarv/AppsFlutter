import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:transparent_image/transparent_image.dart';
class HomeTap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget _buildBodyBack()=> Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 16, 66, 99),
            Color.fromARGB(255, 103, 203, 253)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight
        )
      ),
    );
    return Stack(
      children: [
        _buildBodyBack(),
        CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text("Novidades"),
                centerTitle: true,
              ),
            ),
            FutureBuilder<QuerySnapshot>(
              future: Firestore.instance
                .collection("home").orderBy("pos").getDocuments(),
                // ignore: missing_return
                builder: (context,snapshot){
                if(!snapshot.hasData)
                  return SliverToBoxAdapter(
                    child: Container(
                      height: 200,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor:AlwaysStoppedAnimation<Color>(Colors.white),

                      ),
                    ),
                  );
                else
                  return SliverStaggeredGrid.count(
                  crossAxisCount: 2,
                    mainAxisSpacing: 1,
                    crossAxisSpacing: 1,
                    staggeredTiles: snapshot.data.documents.map((e){
                      return StaggeredTile.count(e.data["x"], e.data["y"]);
                    }).toList(),
                    children:
                      snapshot.data.documents.map((e){
                        return FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: e.data["image"],
                        fit: BoxFit.cover,);
                      }).toList(),
                  );
                }
            )
          ],
        )
      ],
    );
  }
}
