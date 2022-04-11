import 'categoria.dart';

class Etiqueta {
  String _tag;
  Categoria _categoria;
  Etiqueta(this._tag, this._categoria);

  String get tag => _tag;
}
