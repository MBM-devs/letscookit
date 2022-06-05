import 'dart:convert';
import 'package:http/http.dart' as http;

/*
class Ingrediente {
  String _nombre;

  Ingrediente(this._nombre);

  String get nombre => _nombre;
}
 */

class Ingrediente {
  final String _nombre;
  final int _id;

  static const String _baseAddress = 'clados.ugr.es';

  static const String _applicationName = 'DS1_2/api/v1/';

  Ingrediente(this._nombre) : _id = 0;

  /// GETTERS
  int get id => _id;
  String get nombre => _nombre;

  String toString() {
    return "id: " +
        id.toString() +
        ", nombre: " +
        nombre;
  }

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name': nombre,
  };

  Ingrediente.fromJson(Map<String, dynamic> json)
      : _id = json["id"],
        _nombre = json["name"];


  static Future<Ingrediente> getIngrediente(String id) async {
    final response = await http.get(
        Uri.https(_baseAddress, '$_applicationName/ingredients/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response.statusCode == 200) {
      return Ingrediente.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get ingredient');
    }
  }

}