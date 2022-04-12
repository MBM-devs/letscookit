// ? clase template
import 'package:letscookit/utilities/lista.dart';
import 'package:letscookit/utilities/lista_mis_recetas.dart';

import 'lista_receta.dart';
import 'receta.dart';

class LibroRecetas extends Lista {
  // List<ListaReceta> _libroRecetas;
  static final LibroRecetas _instance = LibroRecetas._internal();
  factory LibroRecetas() {
    return _instance;
  }
  LibroRecetas._internal() : super("Ingredientes") {
    inicializarLibro();
  }

  void crearLista(String nombre) => super.add(ListaReceta(nombre));
  void eliminarLista(ListaReceta lista) => super.remove(lista);

  void inicializarLibro() {
    ListaReceta misRecetas = ListaReceta("Mis Recetas");
    super.add(misRecetas);
  }

  void crearNuevaReceta(
      ListaReceta? lista, String nombre, int numPersonas, int tiempo) {
    Receta receta = Receta(nombre, numPersonas, tiempo);
    misRecetas.add(receta);
    if (lista != null) lista.add(receta);
    print(nombre + numPersonas.toString() + tiempo.toString());
  }

  ListaReceta get misRecetas => super.lista[0];
}
