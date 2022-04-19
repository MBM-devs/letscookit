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
    return super.lista.any((element) => element.nombre == nombre);
  }

  // List<String> listToString() {
  //   List<String> result = [];
  //   print("haosdflalsdfjaldsfj");
  //   print("----------" + super.lista.length.toString());
  //   for (int i = 0; i < super.length(); i++) {
  //     result.add(get(i).nombre);
  //   }
  //   return result;
  // }
}
