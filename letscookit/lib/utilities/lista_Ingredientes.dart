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
    //Si no encuentra el ingrediente, entonces lo añade a la lista
    if(buscaIngrediente(ingrediente.nombre) == -1)
      _lista.add(ingrediente);
  }

  int buscaIngrediente(String nombre) {
    return _lista.indexWhere((element) => element.nombre == nombre); //Devuelve -1 si no lo encuentra
  }

  /* bool existeIngrediente(String nombre) {
    return _lista.any((element) => element.nombre == nombre);
  } */
}
