import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:letscookit/utilities/medida.dart';

class IngredientesBD {
  final int index;
  final String nombre;

  static const String _baseAddress = 'clados.ugr.es';

  static const String _applicationName = 'DS1_2/api/v1/ingredients';

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
        Uri.https(_baseAddress, '$_applicationName/$id'),
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
        Uri.https(_baseAddress, '$_applicationName'),
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

  static Future<IngredientesBD> addIngredienteDB(
      String nombre, Medida medida, int idReceta) async {
        String json = jsonEncode(<String, dynamic>{
          'ingredient': {
            'name': nombre,
            'quantity': medida.cantidad,
            'unit': medida.unidad,
            'recipe_id': idReceta
          }
    });
    final response = await http.post(
        Uri.https(_baseAddress, _applicationName),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Accept": "application/json"
        },
        body: json);
    print("JSON: "+json);
    print(response.statusCode.toString() + " A " + json);
    if (response.statusCode == 201) {
      return IngredientesBD.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Error al Añadir");
    }
  }

}