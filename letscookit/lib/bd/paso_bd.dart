import 'dart:convert';
import 'package:http/http.dart' as http;

import '../utilities/paso.dart';

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

  static Future<PasosDB> addPasoDB(String paso, int index, int id_receta) async {
    print("Paso: "+paso+", index: "+index.toString()+", idR"+id_receta.toString());
    String json = jsonEncode(<String, dynamic>{
      'step': {
        'index': index+1,
        'description': paso,
        'recipe_id': id_receta
      }
    });
    print("JSON: "+json);
    final response = await http.post(
        Uri.https(_baseAddress, '$_applicationName/recipes'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Accept": "application/json"
        },
        body: json);

    print("Estado de error: "+response.statusCode.toString());

    if (response.statusCode == 201) {
      return PasosDB.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Error al Añadir");
    }
  }

  static Future<bool> addPasosDB(List<String> pasosList, int id_receta) async {
    bool complete = true;
    print("LISTA PASOS: "+pasosList.toString());
    for(var paso in pasosList){
      print("DESCRIPCION: "+paso);
      PasosDB pasoDB = await addPasoDB(paso, pasosList.indexOf(paso), id_receta);
      if(pasoDB == null){
        complete = false;
      }
    }
    return complete;
  }

}