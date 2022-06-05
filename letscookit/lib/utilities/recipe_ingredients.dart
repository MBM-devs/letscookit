import 'dart:convert';
import 'package:http/http.dart' as http;

class RecipesIngredients {
  final int _id;
  final int _idReceta;
  final int _idIngrediente;
  final int _cantidad;
  final String _unidad;

  static const String _baseAddress = 'clados.ugr.es';

  static const String _applicationName = 'DS1_2/api/v1/';

  ///GETTERS
  int get id => _id;
  int get idReceta => _idReceta;
  int get idIngrediente => _idIngrediente;
  int get cantidad => _cantidad;
  String get unidad => _unidad;

  RecipesIngredients(this._id, this._idReceta, this._idIngrediente,
      this._cantidad, this._unidad);

  Map<String, dynamic> toJson() => {
    'id': _id,
    'recipe_id': _idReceta,
    'ingredient_id': _idIngrediente,
    'quantity': _cantidad,
    'unit': _unidad,
  };

  RecipesIngredients.fromJson(Map<String, dynamic> json)
    : _id = json["id"],
      _idReceta = json["recipe_id"],
      _idIngrediente = json["ingredient_id"],
      _cantidad = json["quantity"],
      _unidad = json["unit"];

  static Future<RecipesIngredients> getRecipesIngredients(String id) async {
    final response = await http.get(
        Uri.https(_baseAddress, '$_applicationName/recipe_ingredients/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response.statusCode == 200) {
      return RecipesIngredients.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get recipes-ingredients relation');
    }
  }

  static Future<List<RecipesIngredients>> getAllRecipesIngredients() async {
    final response = await http.get(
        Uri.https(_baseAddress, '$_applicationName/recipe_ingredients'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if(response.statusCode == 200){
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<RecipesIngredients>((json) => RecipesIngredients.fromJson(json)).toList();
    } else {
      throw Exception('Failed to get recipes-ingredients relations');
    }
  }

}