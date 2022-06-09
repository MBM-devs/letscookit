import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_session/flutter_session.dart';

class ListaBD {
  int id;
  String nombre;
  int idUsuario;

  static const String _baseAddress = 'clados.ugr.es';

  static const String _applicationName = 'DS1_2/api/v1/lists';

  ListaBD(this.id, this.nombre, this.idUsuario);

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': nombre,
    'user_id': idUsuario,
  };

  ListaBD.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        nombre = json["name"],
        idUsuario = json["user_id"];

  //GET
  static Future<ListaBD> getLista(String id) async {
    final response = await http.get(
        Uri.https(_baseAddress, '$_applicationName/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response.statusCode == 200) {
      return ListaBD.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get list');
    }
  }

  //Devuelve las listas que sean del usuario que se ha registrado
  static Future<List<ListaBD>> getListas(String user_id) async {
    final response = await http.get(
        Uri.https(_baseAddress, '$_applicationName/$user_id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if(response.statusCode == 200){
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      print("Parsed: "+parsed.toString());
      return parsed.map<ListaBD>((json) => ListaBD.fromJson(json)).toList();
    } else {
      throw Exception('Failed to get lists');
    }
  }

  static Future<ListaBD> addListaBD(int id, String nombre, int idUsuario) async {
    String json = jsonEncode(<String, dynamic>{
      'list': {
        'id': id,
        'name': nombre,
        'user_id': idUsuario
      }
    });
    final response = await http.post(
        Uri.https(_baseAddress, _applicationName),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Accept": "application/json"
        },
        body: json);

    if (response.statusCode == 201) {
      return ListaBD.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Error al Añadir");
    }
  }

}