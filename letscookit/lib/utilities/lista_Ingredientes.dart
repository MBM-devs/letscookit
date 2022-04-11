import 'package:letscookit/utilities/ingrediente.dart';

class ListaIngredientes {
  List<Ingrediente> _lista = [];
  static final ListaIngredientes _instance = ListaIngredientes._internal();
  factory ListaIngredientes() {
    return _instance;
  }
  ListaIngredientes._internal();

  Ingrediente get(int i) => _lista[i];

  int length() => _lista.length;

  void add(Ingrediente ingrediente) {
    _lista.add(ingrediente);
  }

  bool existexIngrediente(String nombre) {
    return _lista.any((element) => element.nombre == nombre);
  }
}
