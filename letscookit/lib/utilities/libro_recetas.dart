// ? clase template
import 'package:letscookit/utilities/ingrediente.dart';
import 'package:letscookit/utilities/lista.dart';
import 'package:letscookit/utilities/lista_mis_recetas.dart';
import 'package:letscookit/utilities/medida.dart';
import 'package:letscookit/widgets/search_bar.dart';
import 'package:searchfield/searchfield.dart';

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
      ListaReceta? lista,
      String nombre,
      String imagen,
      int numPersonas,
      int tiempo,
      List<String> pasos,
      List<Ingrediente> ingredientes,
      List<Medida> medidas) {
    Receta receta = Receta(nombre, numPersonas, tiempo, imagen);
    for (var i = 0; i < pasos.length; i++) {
      receta.crearPaso(pasos[i]);
    }

    for (var i = 0; i < ingredientes.length; i++) {
      receta.addIngrediente(medidas[i], ingredientes[i]);
    }

    if (misRecetas.buscaReceta(nombre) == -1) misRecetas.add(receta);

    if (lista != null && lista.buscaReceta(nombre) == -1) lista.add(receta);
  }

  ListaReceta get misRecetas => super.lista[0];
}
