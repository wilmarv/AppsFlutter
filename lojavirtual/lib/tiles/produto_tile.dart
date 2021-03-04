import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/datas/produtos_data.dart';
import 'package:lojavirtual/screens/produto_screen.dart';

class ProdutoTile extends StatelessWidget {
  final String type;
  final DataProdutos produto;

  ProdutoTile(this.type, this.produto);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context)=>ProdutoScreen(produto))
        );
      },
      child: Card(
        child: type == "grid"
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 0.8,
                    child: Image.network(
                      produto.images[0],
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Text(
                          produto.title,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "R\$ ${produto.preco.toStringAsFixed(2)}",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ))
                ],
              )
            : Row(
                children: [
                  Flexible(
                      flex: 1,
                      child: Image.network(
                        produto.images[0],
                        fit: BoxFit.cover,
                        height: 250,
                      )),
                  Flexible(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              produto.title,
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "R\$ ${produto.preco.toStringAsFixed(2)}",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ))
                ],
              ),
      ),
    );
  }
}
