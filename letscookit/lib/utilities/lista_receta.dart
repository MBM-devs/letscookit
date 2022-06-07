import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:letscookit/utilities/receta.dart';

import 'lista.dart';


//Es obtener la lista de recetas de la bd (metodo getRecetas del bd.dart)

class ListaReceta extends Lista {
  ListaReceta(String nombre, int id) : super(nombre, id);

  @override
  void set nombre(String nombre) => super.nombre = nombre;

  int buscaReceta(String nombre) {
    return super.lista.indexWhere((element) =>
        element.nombre.toLowerCase() ==
        nombre.toLowerCase()); //Devuelve -1 si no lo encuentra
  }

  @override
  void add(dynamic elemento) {
    if (!lista.any((element) => element == elemento)) {
      super.add(elemento);
    }
  }

}


/*
class ListaReceta {

  late List<Receta> _listaRecetas;
  final String _nombre;

  static const String _baseAddress = 'clados.ugr.es';
  static const String _applicationName = 'DS1_2/api/v1/';

  ListaReceta(this._nombre);

  List<Receta> get listaRecetas => _listaRecetas;
  String get nombre => nombre;

  //Devuelve el indice de la receta que se busca
  int buscaReceta(String nombre) {
    return listaRecetas.indexWhere((receta) =>
    receta.nombre.toLowerCase() ==
        nombre.toLowerCase()); //Devuelve -1 si no lo encuentra
  }

  void add(Receta receta) {
    //Si la receta no está ya en la lista
    if (!listaRecetas.any((recipe) => recipe == receta)) {
      listaRecetas.add(receta);
    }
  }

  //Inicializamos la lista de recetas
  Future<void> setListaRecetas() async {
    _listaRecetas = await getRecetas();
  }

  //petición a la base de datos que devuelve la lista completa de recetas
  static Future<List<Receta>> getRecetas() async {
    final response = await http.get(
        Uri.https(_baseAddress, '$_applicationName/recipes'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if(response.statusCode == 200){
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Receta>((json) => Receta.fromJson(json)).toList();
    } else {
      throw Exception('Failed to get recipes');
    }
  }

}

 */
