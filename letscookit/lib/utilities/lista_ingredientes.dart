import 'package:letscookit/utilities/ingrediente.dart';
import 'package:letscookit/utilities/lista.dart';

class ListaIngredientes extends Lista {
  static final ListaIngredientes _instance = ListaIngredientes._internal();
  factory ListaIngredientes() {
    return _instance;
  }
  ListaIngredientes._internal() : super("Ingredientes");

  int buscaIngrediente(String nombre) {
    return super.lista.indexWhere((element) =>
        element.nombre.toLowerCase() ==
        nombre.toLowerCase()); //Devuelve -1 si no lo encuentra
  }

  bool existeIngrediente(String nombre) {
    return super.lista.any((element) => element.nombre.toLowerCase() == nombre.toLowerCase());
  }

  void add(dynamic ingrediente){
    if (!existeIngrediente(ingrediente.nombre) && ingrediente is Ingrediente) {
      super.lista.add(ingrediente);
    }
  }
}
