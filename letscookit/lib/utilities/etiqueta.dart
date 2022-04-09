import 'categoria.dart';

class Etiqueta {
  String tag;
  Categoria categoria;
  Etiqueta(this.tag, this.categoria);

  String getTag() => tag;
}
