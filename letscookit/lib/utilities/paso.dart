import 'dart:convert';
import 'package:http/http.dart' as http;

/*
class Paso {
  int _numero;
  String _descripcion;

  Paso(this._numero, this._descripcion);

  //getters
  int get numero => _numero;
  String get descripcion => _descripcion;

  //setters
  void set numero(int numero) => this._numero = numero;
  void set descripcion(String descripcion) => this._descripcion = descripcion;
}

 */

class Paso {
  final int _index;
  final String _descripcion;
  final int _idReceta;

  static const String _baseAddress = 'clados.ugr.es';

  static const String _applicationName = 'DS1_2/api/v1/';

  ///GETTERS
  int get index => _index;
  String get descripcion => _descripcion;
  int get receta => _idReceta;

  Paso(this._index, this._descripcion, this._idReceta);

  Map<String, dynamic> toJson() => {
    'index': index,
    'description': descripcion,
    'recipe_id': receta,
  };

  Paso.fromJson(Map<String, dynamic> json)
      : _index = json["index"],
        _descripcion = json["description"],
        _idReceta = json["recipe_id"];

  //GET
  static Future<Paso> getPaso(String id) async {
    final response = await http.get(
        Uri.https(_baseAddress, '$_applicationName/steps/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response.statusCode == 200) {
      return Paso.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get step');
    }
  }

  static Future<List<Paso>> getPasos() async {
    final response = await http.get(
        Uri.https(_baseAddress, '$_applicationName/steps'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if(response.statusCode == 200){
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Paso>((json) => Paso.fromJson(json)).toList();
    } else {
      throw Exception('Failed to get steps');
    }
  }
}