import 'package:flutter/material.dart';
import 'package:letscookit/bd/bd.dart';
import 'package:letscookit/utilities/ingrediente.dart';
import 'package:letscookit/utilities/libro_recetas.dart';
import 'package:letscookit/utilities/lista_ingredientes.dart';
import 'package:letscookit/utilities/paso.dart';
import 'package:letscookit/utilities/receta.dart';

import '../bd/paso_bd.dart';
import '../bd/receta_bd.dart';

import 'package:flutter_session/flutter_session.dart';

class GenerarRecetas {
  int user_id = -1;

  _loadSession() async{
    user_id = await FlutterSession().get("id");
  }

  Future<void> obtenerRecetas() async {

    //Obtenemos el id del usuario con el session
    await _loadSession();

    //LibroRecetas libro = LibroRecetas();
    //print("Libro: "+ libro.misRecetas.nombre);

    BD().setListas(user_id);
    BD().setListaIngredientes();

  }
}
