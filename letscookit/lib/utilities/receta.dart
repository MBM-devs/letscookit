import 'package:letscookit/utilities/lista_ingredientes.dart';
import 'package:letscookit/utilities/paso.dart';
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
