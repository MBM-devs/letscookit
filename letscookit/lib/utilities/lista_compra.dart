import 'package:letscookit/utilities/ingrediente.dart';
import 'package:letscookit/utilities/lista.dart';

class ListaCompra extends Lista {
  ListaCompra._privateConstructor() : super("Lista de la Compra");

  static final ListaCompra _instance = ListaCompra._privateConstructor();

  factory ListaCompra() {
    return _instance;
  }

  bool existeIngrediente(Ingrediente ingrediente) {
    for (int i = 0; i < super.lista.length; i++) {
      if (super.lista[i].keys.first == ingrediente) {
        return true;
      }
    }
    return false;
  }

  @override
  void add(dynamic elemento) {
    if (!existeIngrediente(elemento.keys.first)) lista.add(elemento);
  }
}
