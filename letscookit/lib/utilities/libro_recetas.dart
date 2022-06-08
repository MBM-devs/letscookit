// ? clase template
import 'package:letscookit/bd/lista_bd.dart';
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
      int id,
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


  void setListas(int user_id) async{
    List<ListaBD> listas = await ListaBD.getListas(user_id.toString());
    //Crea las listas del libro
    for(int i=0; i<listas.length; i++){
      crearLista(listas[i].nombre, listas[i].id);
      inicializarLista(listas[i].id, i);
    }
  }

  //Inicializa la lista i (obtener sus recetas con la relacion receta-lista)
  void inicializarLista(int idLista, int index) async{
    List<RecetaListaBD> listaRelacion = await RecetaListaBD.getRelaciones(idLista.toString());


    for(int i=0; i<listaRelacion.length; i++){
      int idReceta = listaRelacion[i].idReceta;
      RecetaDB recetaDB = await RecetaDB.getReceta(idReceta.toString());
      List<PasosDB> listaPasos = await PasosDB.getPasos();
    
      Receta receta = Receta(recetaDB.nombre, recetaDB.nPersonas, recetaDB.duracion, recetaDB.urlImg);

      for(int j=0; j<listaPasos.length; j++){
        PasosDB paso = listaPasos[j];
        //pasoDB = await PasosDB.getPaso((j+1).toString());
        if(paso.receta == idReceta){
          receta.crearPaso(paso.descripcion);
        }
      }

      super.get(index).add(receta);
    }
  
  }

  /* void inicializarListas(){
    for(int i=0; i<super.length(); i++){

      //Aqui hay que pasarle una Receta
      super.get(i).add();
    }
  } */

}
