import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/datas/produtos_data.dart';

class ProdutoScreen extends StatefulWidget {
  final DataProdutos produto;

  ProdutoScreen(this.produto);

  @override
  _ProdutoScreenState createState() => _ProdutoScreenState(produto);
}

class _ProdutoScreenState extends State<ProdutoScreen> {
  final DataProdutos produto;
  String size;

  _ProdutoScreenState(this.produto);

  @override
  Widget build(BuildContext context) {
    final Color primayColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: Text(produto.title),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 0.9,
            child: Carousel(
              images: produto.images.map((e) {
                return NetworkImage(e);
              }).toList(),
              dotSize: 5,
              dotSpacing: 15,
              dotBgColor: Color.fromARGB(100, 135, 206, 250),
              dotColor: primayColor,
              autoplay: false,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  produto.title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  maxLines: 3,
                ),
                Text(
                  "R\$ ${produto.preco.toStringAsFixed(2)}",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: primayColor),
                ),
                SizedBox(
                  height: 16,
                ),
                produto.sizes != null
                    ? Text(
                        "Tamanho",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )
                    : Container(),
                produto.sizes != null
                    ? SizedBox(
                        height: 34,
                        child: GridView(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          scrollDirection: Axis.horizontal,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1,
                                  mainAxisSpacing: 8,
                                  childAspectRatio: 0.5),
                          children: produto.sizes.map((e) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  size = e;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    border: Border.all(
                                      width: 3,
                                      color: e == size
                                          ? primayColor
                                          : Colors.grey[500],
                                    )),
                                width: 50,
                                alignment: Alignment.center,
                                child: Text(e),
                              ),
                            );
                          }).toList(),
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 44,
                  child: RaisedButton(
                    onPressed:
                        size != null || produto.sizes == null ? () {} : null,
                    child: Text(
                      "Adicionar ao Carrinho",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    color: primayColor,
                    textColor: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Text("Descrição",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                Text(produto.descricao,
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
