import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_session/flutter_session.dart';

class RecetaListaBD {
  int id;
  int idLista;
  int idReceta;

  static const String _baseAddress = 'clados.ugr.es';

  static const String _applicationName = 'DS1_2/api/v1/recipes_lists';

  RecetaListaBD(this.id, this.idLista, this.idReceta);

  Map<String, dynamic> toJson() => {
    'id': id,
    'list_id': idLista,
    'recipe_id': idReceta,
  };

  RecetaListaBD.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        idLista = json["list_id"],
        idReceta = json["recipe_id"];

  //GET
  static Future<RecetaListaBD> getLista(String id) async {
    final response = await http.get(
        Uri.https(_baseAddress, '$_applicationName/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response.statusCode == 200) {
      return RecetaListaBD.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get list');
    }
  }

  //Devuelve las listas que sean del usuario que se ha registrado
  static Future<List<RecetaListaBD>> getRelaciones(String idLista) async {
    //print("ID LISTA EN LA RELACION: "+idLista);
    final response = await http.get(
        Uri.https(_baseAddress, '$_applicationName/$idLista'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    //print("RESPUESTA: "+response.body.toString());
    if(response.statusCode == 200){
      /* var jsonData = json.decode(response.body);
      List<RecetaListaBD> relaciones = [];

      for(var i in jsonData){
        print(i.toString());
        RecetaListaBD recetaListaBD = RecetaListaBD(i["id"], i["list_id"], i["recipe_id"]);
        relaciones.add(recetaListaBD);
      }

      print(relaciones.length.toString());
      return relaciones; */

      /*
      List<RecetaListaBD> lista = [];
      for(int i=0; i<response.body.length; i++){

        RecetaListaBD receta = RecetaListaBD.fromJson(json.decode(response.body));
        lista.add(receta);
      }
      //RecetaListaBD receta = RecetaListaBD.fromJson(json.decode(response.body));
      
      print(lista[0].toJson());
      return lista;
       */

      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<RecetaListaBD>((json) => RecetaListaBD.fromJson(json)).toList();
    } else {
      throw Exception('Failed to get lists');
    }
  }

}