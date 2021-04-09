import 'package:carros/pages/carro/carro_tipo.dart';
import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carro_api.dart';

import 'package:mobx/mobx.dart';

part 'carro_model.g.dart';

class CarroModel = CarroModelBase with _$CarroModel;


abstract class CarroModelBase with Store {

  @observable
  List<Carro> carros;

  @observable
  Exception error;

  @action
  loadData(CarroTipo tipo) async {
    try {
      error = null;

      this.carros = await CarroApi.getCarrosPorTipo(tipo.getName());
    } catch (e) {
      error = e;
    }
  }

}