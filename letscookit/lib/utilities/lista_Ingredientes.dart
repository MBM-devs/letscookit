import 'package:letscookit/utilities/ingrediente.dart';
import 'package:letscookit/utilities/lista.dart';

class ListaIngredientes extends Lista {
  static final ListaIngredientes _instance = ListaIngredientes._internal();
  factory ListaIngredientes() {
    return _instance;
  }
  ListaIngredientes._internal() : super("Ingredientes");

  int buscaIngrediente(String nombre) {
    return super.lista.indexWhere(
        (element) => element.nombre == nombre); //Devuelve -1 si no lo encuentra
  }

  /* bool existeIngrediente(String nombre) {
    return _lista.any((element) => element.nombre == nombre);
  } */
}