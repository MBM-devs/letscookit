import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:letscookit/utilities/lista_ingredientes.dart';
import 'package:letscookit/utilities/paso.dart';
import 'package:letscookit/utilities/recipe_ingredients.dart';
import 'ingrediente.dart';
import 'etiqueta.dart';
import 'medida.dart';

//Convertirlo al de la db


class Receta {
  String _nombre;
  int _numPersonas;
  int _duracion;
  // String _imagen;
  String _imagen;
  bool _realizada;
  List<Paso> _pasos; // * Tiene que estar ordenada
  Map<Ingrediente, Medida> _ingredientes;
  List<Etiqueta> _etiquetas;
  ListaIngredientes _listaIngredientes;

  //Constructor
  Receta(this._nombre, this._numPersonas, this._duracion, this._imagen)
      : _realizada = false,
        _pasos = [],
        _ingredientes = {},
        _listaIngredientes = ListaIngredientes(),
        _etiquetas = [];

  // setters
  set nombre(String nombre) => _nombre = nombre;
  set numPersonas(int numPersonas) => _numPersonas = numPersonas;
  set realizada(bool realizada) => _realizada = realizada;

  // getters
  String get nombre => _nombre;
  int get numPersonas => _numPersonas;
  bool get realizada => _realizada;
  int get duracion => _duracion;
  String get imagen => _imagen;

  /// Devuelve el numero de pasos de la receta
  int get numPasos => _pasos.length;

  /// Devuelve el numero de ingredientes de la receta
  int get numIngredientes => _ingredientes.length;

  /// Devuelve la lista de ingredientes de la receta
  Map<Ingrediente, Medida> get ingredientes => _ingredientes;

  /// Devuelve el paso en la posicion i
  Paso getPaso(int i) => _pasos[i];

  /// Devuelve la etiqueta en la posicion i
  Etiqueta getEtiqueta(int i) => _etiquetas[i];

  void addIngrediente(Medida medida, Ingrediente ingrediente) {
    _ingredientes[ingrediente] = medida;
    _listaIngredientes.add(ingrediente);
  }

  void addEtiqueta(Etiqueta etiqueta) => _etiquetas.add(etiqueta);

  /// Crea un paso y lo añade al array
  void crearPaso(String descripcion) {
    Paso paso = Paso(_pasos.length, descripcion);
    _pasos.add(paso);
  }

  /// Crea un Ingrediente, le asigna una cantidad y unidad y lo añade a la lista
  void crearIngrediente(int cantidad, String unidad, String nombre) {
    int index = _listaIngredientes.buscaIngrediente(nombre);
    Ingrediente ingrediente;
    if (index == -1) {
      ingrediente = Ingrediente(nombre);
      _listaIngredientes.add(ingrediente);
    } else {
      ingrediente = ListaIngredientes().get(index);
    }
    Medida medida = Medida(cantidad, unidad);
    _ingredientes[ingrediente] = medida;
  }
}


/*
class Receta {
  final String _nombre;
  final int _duracion;
  final int _numPersonas;
  final int _id;
  String _imagen;
  bool _realizada;
  List<Paso> _pasos; // * Tiene que estar ordenada
  List<Ingrediente> _ingredientesReceta; //lista de los ingredientes de esta receta
  List<Etiqueta> _etiquetas;
  List<RecipesIngredients> listaRecetaIngr;
  //Map<Ingrediente, Medida> _ingredientes;
  //ListaIngredientes _listaIngredientes; //lista de todos lo ingredientes de la bd?

  static const String _baseAddress = 'clados.ugr.es';

  static const String _applicationName = 'DS1_2/api/v1/';

  Receta(this._id, this._nombre, this._numPersonas, this._duracion)
      : _realizada = false,
        _pasos = [],
        _ingredientesReceta = [],
        _imagen = "assets/noimageavailable.png",
        //_listaIngredientes = ListaIngredientes(),
        //_ingredientes = {},
        _etiquetas = [],
        listaRecetaIngr = [];

  /// GETTERS
  int get id => _id;
  String get nombre => _nombre;
  int get numPersonas => _numPersonas;
  bool get realizada => _realizada;
  int get duracion => _duracion;
  String get imagen => _imagen;

  /// Devuelve el numero de pasos de la receta
  int get numPasos => _pasos.length;

  /// Devuelve el numero de ingredientes de la receta
  int get numIngredientes => _ingredientesReceta.length;

  /// Devuelve la lista de ingredientes de la receta
  List<Ingrediente> get ingredientesReceta => _ingredientesReceta;

  /// Devuelve el map de ingredientes de la receta
  //Map<Ingrediente, Medida> get ingredientes => _ingredientes;

  /// Devuelve el paso en la posicion i
  Paso getPaso(int i) => _pasos[i];

  /// Devuelve la etiqueta en la posicion i
  Etiqueta getEtiqueta(int i) => _etiquetas[i];


  void addPaso(Paso paso) {
    _pasos.add(paso);
  }

  void addIngrediente(Ingrediente ingr){
    _ingredientesReceta.add(ingr);
  }

  String toString() {
    return "id: " +
        id.toString() +
        ", nombre: " +
        nombre +
        ", duracion: " +
        duracion.toString() +
        ", nPersonas: " +
        numPersonas.toString();
  }

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name': nombre,
    'duration': duracion,
    'people': numPersonas,
  };

  Receta.fromJson(Map<String, dynamic> json)
      : _id = json["id"],
        _nombre = json["name"],
        _duracion = json["duration"],
        _numPersonas = json["people"],
        //Hay que inicializar todos los atributos
        _realizada = false,
        _pasos = [],
        _ingredientesReceta = [],
        _imagen = "assets/noimageavailable.png",
        //_listaIngredientes = ListaIngredientes(),
        //_ingredientes = {},
        _etiquetas = [],
        listaRecetaIngr = [];

  //GET -> obtener una receta de la bd por su índice en la misma
  Future<Receta> getReceta(String id) async {
    final response = await http.get(
        Uri.https(_baseAddress, '$_applicationName/recipes/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response.statusCode == 200) {
      listaRecetaIngr = RecipesIngredients.getAllRecipesIngredients() as List<RecipesIngredients>;
      for(int i=0; i<listaRecetaIngr.length; i++){
        //Si el id de la receta coincide con el de la relacion, guarda ese ingrediente
        if(_id == listaRecetaIngr[i].idReceta){
          ingredientesReceta.add(Ingrediente.getIngrediente(
              listaRecetaIngr[i].idIngrediente.toString())
          as Ingrediente);
        }
      }
      return Receta.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get recipe');
    }
  }
}

 */