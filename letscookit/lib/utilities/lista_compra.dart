import 'package:letscookit/utilities/ingrediente.dart';
import 'package:letscookit/utilities/lista.dart';

class ListaCompra extends Lista {
  ListaCompra._privateConstructor() : super("Lista de la Compra");

  static final ListaCompra _instance = ListaCompra._privateConstructor();

  factory ListaCompra() {
    return _instance;
  }
}
