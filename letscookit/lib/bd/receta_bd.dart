import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_session/flutter_session.dart';


class RecetaDB {
  String nombre;
  int duracion;
  int nPersonas;
  String urlImg;

  int idReceta;

  static const String _baseAddress = 'clados.ugr.es';

  static const String _applicationName = 'DS1_2/api/v1/';

  RecetaDB(this.nombre, this.duracion, this.nPersonas, this.urlImg) : idReceta = -1;


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
    'url_img': urlImg,
    'id': idReceta,
  };

  RecetaDB.fromJson(Map<String, dynamic> json)
      : nombre = json["name"],
        duracion = json["duration"],
        nPersonas = json["people"],
        urlImg = json["url_img"],
        idReceta = json["id"];

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
