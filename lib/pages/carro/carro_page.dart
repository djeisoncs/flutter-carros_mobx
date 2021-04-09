import 'package:carros/pages/carro/carro.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CarroPage extends StatelessWidget {
  Carro carro;

  CarroPage(this.carro);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(carro.nome),
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Image.network(carro.urlFoto),
    );
  }
}
