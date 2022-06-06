import 'dart:convert';
import 'package:http/http.dart' as http;

class IngredientesBD {
  final int index;
  final String nombre;

  static const String _baseAddress = 'clados.ugr.es';

  static const String _applicationName = 'DS1_2/api/v1/';

  IngredientesBD(this.index, this.nombre);

  Map<String, dynamic> toJson() => {
    'index': index,
    'name': nombre,
  };

  IngredientesBD.fromJson(Map<String, dynamic> json)
      : index = json["index"],
        nombre = json["name"];

  //GET
  static Future<IngredientesBD> getIngrediente(String id) async {
    final response = await http.get(
        Uri.https(_baseAddress, '$_applicationName/ingredients/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response.statusCode == 200) {
      return IngredientesBD.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get ingredient');
    }
  }

  static Future<List<IngredientesBD>> getIngredientes() async {
    final response = await http.get(
        Uri.https(_baseAddress, '$_applicationName/ingredients'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if(response.statusCode == 200){
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<IngredientesBD>((json) => IngredientesBD.fromJson(json)).toList();
    } else {
      throw Exception('Failed to get ingredients');
    }
  }

}