import 'package:letscookit/utilities/ingrediente.dart';
import 'package:letscookit/utilities/lista.dart';

class ListaCompra {
  Map<Ingrediente, bool> lista;
  ListaCompra._privateConstructor() : lista = {};

  static final ListaCompra _instance = ListaCompra._privateConstructor();

  factory ListaCompra() {
    return _instance;
  }

  void add(Ingrediente ingrediente) {
    if (!lista.containsKey(ingrediente)) {
      lista[ingrediente] = false;
    }
  }

  Ingrediente getIngrediente(int i) {
    return lista.keys.elementAt(i);
  }

  bool getCheck(Ingrediente i) {
    if (lista.containsKey(i)) {
      return lista[i]!;
    } else {
      return false;
    }
  }

  void setCheck(Ingrediente ingrediente, bool check) {
    if (lista.containsKey(ingrediente)) {
      lista[ingrediente] = check;
    }
  }

  int length() {
    return lista.length;
  }
}
