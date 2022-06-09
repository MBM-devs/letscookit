import 'dart:convert';
import 'package:http/http.dart' as http;

class RecetaIngredienteBD {
  final int _id;
  final int _idReceta;
  final int _idIngrediente;
  final int _cantidad;
  final String _unidad;

  static const String _baseAddress = 'clados.ugr.es';

  static const String _applicationName = 'DS1_2/api/v1/recipe_ingredients';

  ///GETTERS
  int get id => _id;
  int get idReceta => _idReceta;
  int get idIngrediente => _idIngrediente;
  int get cantidad => _cantidad;
  String get unidad => _unidad;

  RecetaIngredienteBD(this._id, this._idReceta, this._idIngrediente,
      this._cantidad, this._unidad);

  Map<String, dynamic> toJson() => {
    'id': _id,
    'recipe_id': _idReceta,
    'ingredient_id': _idIngrediente,
    'quantity': _cantidad,
    'unit': _unidad,
  };

  RecetaIngredienteBD.fromJson(Map<String, dynamic> json)
      : _id = json["id"],
        _idReceta = json["recipe_id"],
        _idIngrediente = json["ingredient_id"],
        _cantidad = json["quantity"],
        _unidad = json["unit"];

  //Busca por id de la receta y devuelve todas las relaciones de esa receta
  static Future<List<RecetaIngredienteBD>> getRelacionesRecetaIngrediente(String id) async {
    final response = await http.get(
        Uri.https(_baseAddress, '$_applicationName/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if(response.statusCode == 200){
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<RecetaIngredienteBD>((json) => RecetaIngredienteBD.fromJson(json)).toList();
    } else {
      throw Exception('Failed to get recipes-ingredients relations');
    }

    /*if (response.statusCode == 200) {
      return RecetaIngredienteBD.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get recipes-ingredients relation');
    }
     */
  }

  static Future<List<RecetaIngredienteBD>> getAllRecipesIngredients() async {
    final response = await http.get(
        Uri.https(_baseAddress, _applicationName),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if(response.statusCode == 200){
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<RecetaIngredienteBD>((json) => RecetaIngredienteBD.fromJson(json)).toList();
    } else {
      throw Exception('Failed to get recipes-ingredients relations');
    }
  }

  static Future<RecetaIngredienteBD> addRelRecetaIngredienteBD(int id, int idReceta, int idIngr, int cantidad, String unidad) async {
    String json = jsonEncode(<String, dynamic>{
      'recipe_ingredients': {
        'id': id,
        'recipe_id': idReceta,
        'ingredient_id': idIngr,
        'quantity': cantidad,
        'unit': unidad,
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
      return RecetaIngredienteBD.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Error al Añadir relacion Receta-Ingrediente");
    }
  }

}