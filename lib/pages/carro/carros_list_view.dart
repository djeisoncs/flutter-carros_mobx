import 'package:carros/pages/carro/carro_model.dart';
import 'package:carros/pages/carro/carro_page.dart';
import 'package:carros/pages/carro/carro_tipo.dart';
import 'package:carros/util/nav.dart';
import 'package:carros/util/text_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'carro.dart';

// ignore: must_be_immutable
class CarrosListView extends StatefulWidget {
  CarroTipo tipo;

  CarrosListView(this.tipo);

  @override
  _CarrosListViewState createState() => _CarrosListViewState();
}

class _CarrosListViewState extends State<CarrosListView>
    with AutomaticKeepAliveClientMixin<CarrosListView> {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  final _model = CarroModel();

  CarroTipo get tipo => widget.tipo;

  void _fetch() {
    _model.loadData(tipo);
  }

  @override
  void initState() {
    super.initState();

    _fetch();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Observer(builder: (_) {
      List<Carro> carros = _model.carros;
      if (_model.error != null) {
        return TextError(
          "Não foi possível buscar os carros\n\nClique aqui para tentar novamente",
          onPressed: _fetch,
        );
      }

      if (carros == null) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }

      return _listView(carros);
    });
  }

  Container _listView(List<Carro> carros) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: carros.length,
        itemBuilder: (context, index) {
          Carro c = carros[index];

          return Card(
            color: Colors.grey[100],
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Image.network(
                      c.urlFoto ??
                          "http://www.livroandroid.com.br/livro/carros/esportivos/Ferrari_FF.png",
                      width: 250,
                    ),
                  ),
                  Text(
                    c.nome ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 25),
                  ),
                  Text(
                    "descrição...",
                    style: TextStyle(fontSize: 16),
                  ),
                  ButtonBarTheme(
                    data: ButtonBarThemeData(),
                    child: ButtonBar(
                      children: <Widget>[
                        FlatButton(
                          child: const Text('DETALHES'),
                          onPressed: () => _onClickDetalheCarro(c),
                        ),
                        FlatButton(
                          child: const Text('SHARE'),
                          onPressed: () {
                            /* ... */
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _onClickDetalheCarro(Carro c) {
    navigate(context, CarroPage(c));
  }
}
