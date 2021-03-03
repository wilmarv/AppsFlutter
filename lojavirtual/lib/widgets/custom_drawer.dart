import 'package:flutter/material.dart';
import 'package:lojavirtual/tiles/drawer_tile.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget _buildDrawerBack() =>
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 103, 203, 253),
                    Colors.white
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter
              )
          ),
        );
    return Drawer(
      child: Stack(
        children: [
          _buildDrawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 32, top: 16),
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 8),
                padding: EdgeInsets.fromLTRB(0, 16, 16, 8),
                height: 170,
                child: Stack(
                  children: [
                    Positioned(
                      top: 8,
                      left: 0,
                      child: Text(
                        "Flutter's\nClothing",
                        style: TextStyle(
                            fontSize: 34, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Positioned(
                        left: 0.0,
                        bottom: 0.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Olá,",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                              ),),
                            GestureDetector(
                              child: Text("Entre ou cadastre-se >",
                                style: TextStyle(
                                    color: Theme
                                        .of(context)
                                        .primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold
                                ),),
                              onTap: (){},
                            )
                          ],
                        ))
                  ],
                ),
              ),
              Divider(),
              DrawerTile(Icons.home,"Inicio"),
              DrawerTile(Icons.list,"Produtos"),
              DrawerTile(Icons.location_on,"Lojas"),
              DrawerTile(Icons.playlist_add_check,"Meus Pedidos"),
            ],
          )
        ],
      ),
    );
  }
}
