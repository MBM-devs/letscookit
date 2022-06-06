import 'dart:convert';
import 'package:http/http.dart' as http;

class ListaBD {
  final int index;
  final String nombre;
  final int userID;

  static const String _baseAddress = 'clados.ugr.es';

  static const String _applicationName = 'DS1_2/api/v1/';

  ListaBD(this.index, this.nombre, this.userID);

  Map<String, dynamic> toJson() => {
    'index': index,
    'name': nombre,
    'user_id': userID,
  };

  ListaBD.fromJson(Map<String, dynamic> json)
      : index = json["index"],
        nombre = json["name"],
        userID = json["user_id"];

  //GET
  static Future<ListaBD> getLista(String id) async {
    final response = await http.get(
        Uri.https(_baseAddress, '$_applicationName/lists/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response.statusCode == 200) {
      return ListaBD.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get list');
    }
  }

  static Future<List<ListaBD>> getListas() async {
    final response = await http.get(
        Uri.https(_baseAddress, '$_applicationName/list'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if(response.statusCode == 200){
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<ListaBD>((json) => ListaBD.fromJson(json)).toList();
    } else {
      throw Exception('Failed to get lists');
    }
  }

}