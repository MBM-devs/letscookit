// ? clase template
import 'package:letscookit/utilities/ingrediente.dart';
import 'package:letscookit/utilities/lista.dart';
import 'package:letscookit/utilities/lista_mis_recetas.dart';
import 'package:letscookit/utilities/medida.dart';
import 'package:letscookit/utilities/paso.dart';
import 'funciones_comprobacion.dart';
import 'lista_receta.dart';
import 'receta.dart';

//FUERA

class LibroRecetas extends Lista {
  static final LibroRecetas _instance = LibroRecetas._internal();
  factory LibroRecetas() {
    return _instance;
  }
  LibroRecetas._internal() : super("Libro de recetas") {
    inicializarLibro();
  }

  void crearLista(String nombre) => super.add(ListaReceta(nombre));

  void eliminarLista(ListaReceta lista) {
    if (LibroRecetas().get(0) != lista) super.remove(lista);
  }

  void inicializarLibro() {
    ListaReceta misRecetas = ListaReceta("Mis Recetas");
    super.add(misRecetas);
  }

  void crearNuevaReceta(
      ListaReceta? lista,
      int id,
      String nombre,
      String imagen,
      int numPersonas,
      int tiempo,
      List<Paso> pasos,
      List<Ingrediente> ingredientes) {
    Receta receta = Receta(id, nombre, numPersonas, tiempo);
    for (var i = 0; i < pasos.length; i++) {
      receta.addPaso(pasos[i]);
    }

    for (var i = 0; i < ingredientes.length; i++) {
      receta.addIngrediente(ingredientes[i]);
    }

    if (misRecetas.buscaReceta(nombre) == -1) misRecetas.add(receta);

    if (lista != null && lista.buscaReceta(nombre) == -1) lista.add(receta);
  }

  ListaReceta get misRecetas => super.lista[0];
}
