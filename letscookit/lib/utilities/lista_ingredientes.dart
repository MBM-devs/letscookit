import 'package:letscookit/utilities/ingrediente.dart';
import 'package:letscookit/utilities/lista.dart';
import 'funciones_comprobacion.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

//Hacer que obtenga la lista de la bd
/*
class ListaIngredientes{
  List<Ingrediente> _listaIngredientes = [];

  static const String _baseAddress = 'clados.ugr.es';

  static const String _applicationName = 'DS1_2/api/v1/';

  List<Ingrediente> get listaIngredientes => _listaIngredientes;

  Ingrediente get(int index){
    return listaIngredientes[index];
  }

  int buscaIngrediente(String nombre) {
    return listaIngredientes.indexWhere((element) =>
    removeDiacritics((element.nombre)).toLowerCase() ==
        removeDiacritics(nombre)
            .toLowerCase()); //Devuelve -1 si no lo encuentra
  }

  bool existeIngrediente(String nombre) {
    return listaIngredientes.any((element) =>
    removeDiacritics((element.nombre)).toLowerCase() ==
        removeDiacritics(nombre).toLowerCase());
  }

  void add(dynamic ingrediente) {
    if (!existeIngrediente(ingrediente.nombre) && ingrediente is Ingrediente) {
      listaIngredientes.add(ingrediente);
    }
  }


  static Future<List<Ingrediente>> getIngredientes() async {
    final response = await http.get(
        Uri.https(_baseAddress, '$_applicationName/ingredients'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if(response.statusCode == 200){
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Ingrediente>((json) => Ingrediente.fromJson(json)).toList();
    } else {
      throw Exception('Failed to get steps');
    }
  }

}
 */

class ListaIngredientes extends Lista {
  static final ListaIngredientes _instance = ListaIngredientes._internal();
  factory ListaIngredientes() {
    return _instance;
  }
  ListaIngredientes._internal() : super("Ingredientes", 1);

  int buscaIngrediente(String nombre) {
    return super.lista.indexWhere((element) =>
        removeDiacritics((element.nombre)).toLowerCase() ==
        removeDiacritics(nombre)
            .toLowerCase()); //Devuelve -1 si no lo encuentra
  }

  bool existeIngrediente(String nombre) {
    return super.lista.any((element) =>
        removeDiacritics((element.nombre)).toLowerCase() ==
        removeDiacritics(nombre).toLowerCase());
  }

  void add(dynamic ingrediente) {
    if (!existeIngrediente(ingrediente.nombre) && ingrediente is Ingrediente) {
      super.lista.add(ingrediente);
    }
  }
}

