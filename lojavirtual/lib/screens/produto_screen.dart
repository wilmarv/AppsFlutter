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
  _ProdutoScreenState(this.produto);
  @override
  Widget build(BuildContext context) {

    return Container();
  }
}
