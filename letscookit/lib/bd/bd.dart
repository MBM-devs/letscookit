import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:letscookit/utilities/paso.dart';

class RecetaDB {
  final String nombre;
  final int duracion;
  final int nPersonas;

  static const String _baseAddress = 'clados.ugr.es';

  static const String _applicationName = 'DS1_2/api/v1/';

  RecetaDB(this.nombre, this.duracion, this.nPersonas);

  String toString() {
    return "nombre: " +
        nombre +
        ", duracion: " +
        duracion.toString() +
        ", nPersonas: " +
        nPersonas.toString();
  }

  Map<String, dynamic> toJson() => {
        'name': nombre,
        'duration': duracion,
        'people': nPersonas,
      };

  RecetaDB.fromJson(Map<String, dynamic> json)
      : nombre = json["name"],
        duracion = json["duration"],
        nPersonas = json["people"];

  //GET
  static Future<RecetaDB> getReceta(String id) async {
    final response = await http.get(
        Uri.https(_baseAddress, '$_applicationName/recipes/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response.statusCode == 200) {
      return RecetaDB.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get recipe');
    }
  }

  static Future<List<RecetaDB>> getRecetas() async {
    final response = await http.get(
        Uri.https(_baseAddress, '$_applicationName/recipes'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if(response.statusCode == 200){
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<RecetaDB>((json) => RecetaDB.fromJson(json)).toList();
    } else {
      throw Exception('Failed to get recipes');
    }
  }

}


class PasosDB {
  final int index;
  final String descripcion;
  final int receta;

  static const String _baseAddress = 'clados.ugr.es';

  static const String _applicationName = 'DS1_2/api/v1/';

  PasosDB(this.index, this.descripcion, this.receta);

  Map<String, dynamic> toJson() => {
    'index': index,
    'description': descripcion,
    'recipe_id': receta,
  };

  PasosDB.fromJson(Map<String, dynamic> json)
      : index = json["index"],
        descripcion = json["description"],
        receta = json["recipe_id"];

  //GET
  static Future<PasosDB> getPaso(String id) async {
    final response = await http.get(
        Uri.https(_baseAddress, '$_applicationName/steps/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response.statusCode == 200) {
      return PasosDB.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get step');
    }
  }

  static Future<List<PasosDB>> getPasos() async {
    final response = await http.get(
        Uri.https(_baseAddress, '$_applicationName/steps'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if(response.statusCode == 200){
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<PasosDB>((json) => PasosDB.fromJson(json)).toList();
    } else {
      throw Exception('Failed to get steps');
    }
  }

}

