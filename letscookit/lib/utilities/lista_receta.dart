import 'package:letscookit/utilities/libro_recetas.dart';
import 'package:letscookit/utilities/lista.dart';

class ListaReceta extends Lista {
  ListaReceta(String nombre) : super(nombre);

  @override
  void set nombre(String nombre) => super.nombre = nombre;

  int buscaReceta(String nombre) {
    return super.lista.indexWhere(
        (element) => element.nombre == nombre); //Devuelve -1 si no lo encuentra
  }
}
