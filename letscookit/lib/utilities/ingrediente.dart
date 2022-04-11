import 'package:letscookit/utilities/lista_Ingredientes.dart';

class Ingrediente {
  String _nombre;
  ListaIngredientes _listaIngredientes;
  // List<String> alergenos;

  Ingrediente(this._nombre) : _listaIngredientes = ListaIngredientes() {
    _listaIngredientes.add(this);
  }

  String get nombre => _nombre;
}
