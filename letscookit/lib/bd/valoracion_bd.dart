import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_session/flutter_session.dart';

class ValoracionBD {
  int id;
  int idUsuario;
  int idReceta;
  int valoracion;

  static const String _baseAddress = 'clados.ugr.es';

  static const String _applicationName = 'DS1_2/api/v1/ratings';

  ValoracionBD(this.id, this.idUsuario, this.idReceta, this.valoracion);

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': idUsuario,
    'recipe_id': idReceta,
    'rating': valoracion,
  };

  ValoracionBD.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        idUsuario = json["user_id"],
        idReceta = json["recipe_id"],
        valoracion = json["rating"];


  //Devuelve las valoraciones que sean de la receta solicitada
  static Future<List<ValoracionBD>> getValoraciones(String idReceta) async {
    final response = await http.get(
        Uri.https(_baseAddress, '$_applicationName/$idReceta'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if(response.statusCode == 200){
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      print("Parsed: "+parsed.toString());
      return parsed.map<ValoracionBD>((json) => ValoracionBD.fromJson(json)).toList();
    } else {
      throw Exception('Failed to get lists');
    }
  }


}