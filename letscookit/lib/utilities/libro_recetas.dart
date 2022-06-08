// ? clase template
import 'package:letscookit/bd/bd.dart';
import 'package:letscookit/bd/ingredientes_bd.dart';
import 'package:letscookit/bd/lista_bd.dart';
import 'package:letscookit/bd/receta-ingrediente_bd.dart';
import 'package:letscookit/bd/receta-lista_bd.dart';
import 'package:letscookit/bd/receta_bd.dart';
import 'package:letscookit/utilities/ingrediente.dart';
import 'package:letscookit/utilities/lista.dart';
import 'package:letscookit/utilities/lista_mis_recetas.dart';
import 'package:letscookit/utilities/medida.dart';
import 'package:letscookit/utilities/paso.dart';
import '../bd/paso_bd.dart';
import 'funciones_comprobacion.dart';
import 'lista_receta.dart';
import 'receta.dart';

//FUERA

class LibroRecetas extends Lista {

  static final LibroRecetas _instance = LibroRecetas._internal();
  factory LibroRecetas() {
    return _instance;
  }
  LibroRecetas._internal() : super("Libro de recetas", 0) {
    inicializarLibro();
  }

  void crearLista(String nombre, int id) => super.add(ListaReceta(nombre, id));

  void eliminarLista(ListaReceta lista) {
    if (LibroRecetas().get(0) != lista) super.remove(lista);
  }

  void inicializarLibro() {
    ListaReceta misRecetas = ListaReceta("Mis Recetas", 0);
    super.add(misRecetas);
  }

  void crearNuevaReceta(
      ListaReceta? lista,
      String nombre,
      String imagen,
      int numPersonas,
      int tiempo,
      List<Paso> pasos,
      List<Ingrediente> ingredientes,
      List<Medida> medidas) {
    Receta receta = Receta(nombre, numPersonas, tiempo, imagen);
    for (var i = 0; i < pasos.length; i++) {
      receta.crearPaso(pasos[i].descripcion);
    }

    for (var i = 0; i < ingredientes.length; i++) {
      receta.addIngrediente(medidas[i], ingredientes[i]);
    }

    if (misRecetas.buscaReceta(nombre) == -1) misRecetas.add(receta);

    if (lista != null && lista.buscaReceta(nombre) == -1) lista.add(receta);
  }

  ListaReceta get misRecetas => super.lista[0];


}
