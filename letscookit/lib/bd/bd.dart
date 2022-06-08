import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:letscookit/bd/paso_bd.dart';
import 'package:letscookit/bd/receta-ingrediente_bd.dart';
import 'package:letscookit/bd/receta-lista_bd.dart';
import 'package:letscookit/bd/receta_bd.dart';
import 'package:letscookit/utilities/libro_recetas.dart';
import 'dart:convert' as convert;

import 'package:letscookit/utilities/paso.dart';

import '../utilities/receta.dart';
import 'ingredientes_bd.dart';
import 'lista_bd.dart';


class BD {

  void setListas(int user_id) async{
    List<ListaBD> listas = await ListaBD.getListas(user_id.toString());
    //Crea las listas del libro
    for(int i=0; i<listas.length; i++){
      LibroRecetas().crearLista(listas[i].nombre, listas[i].id);
      inicializarLista(listas[i].id, i);
    }
  }

//Inicializa la lista i (obtener sus recetas con la relacion receta-lista)
//igual esta funcion sería lo suyo tenerla en otra clase pero de mientras la dejo aqui pa ir comprobando que el resto de cosas funciona
  void inicializarLista(int idLista, int index) async {
    List<RecetaListaBD> listaRelacion = await RecetaListaBD.getRelaciones(
        idLista.toString());


    for (int i = 0; i < listaRelacion.length; i++) {
      int idReceta = listaRelacion[i].idReceta;
      RecetaDB recetaDB = await RecetaDB.getReceta(idReceta.toString());
      List<PasosDB> listaPasos = await PasosDB.getPasos();

      Receta receta = Receta(
          recetaDB.nombre, recetaDB.nPersonas, recetaDB.duracion,
          recetaDB.urlImg);

      for (int j = 0; j < listaPasos.length; j++) {
        PasosDB paso = listaPasos[j];
        //pasoDB = await PasosDB.getPaso((j+1).toString());
        if (paso.receta == idReceta) {
          receta.crearPaso(paso.descripcion);
        }
      }

      //Para cada receta, busca las relaciones de ingredientes que tenga
      List<RecetaIngredienteBD> listaRelacionIngr = await RecetaIngredienteBD
          .getRelacionesRecetaIngrediente(idReceta.toString());
      //List<IngredientesBD> listaIngredientes = await IngredientesBD.getIngredientes();

      for (int j = 0; j < listaRelacionIngr.length; j++) {
        IngredientesBD ingrediente = await IngredientesBD.getIngrediente(
            listaRelacionIngr[j].idIngrediente.toString());
        receta.crearIngrediente(
            listaRelacionIngr[j].cantidad, listaRelacionIngr[j].unidad,
            ingrediente.nombre);
      }

      LibroRecetas().get(index).add(receta);
    }
  }
}