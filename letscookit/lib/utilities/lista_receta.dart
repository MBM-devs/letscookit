import 'package:letscookit/utilities/lista.dart';

//Es obtener la lista de recetas de la bd (metodo getRecetas del bd.dart)

class ListaReceta extends Lista {
  ListaReceta(String nombre) : super(nombre);

  @override
  void set nombre(String nombre) => super.nombre = nombre;

  int buscaReceta(String nombre) {
    return super.lista.indexWhere((element) =>
        element.nombre.toLowerCase() ==
        nombre.toLowerCase()); //Devuelve -1 si no lo encuentra
  }

  @override
  void add(dynamic elemento) {
    if (!lista.any((element) => element == elemento)) {
      super.add(elemento);
    }
  }
}
