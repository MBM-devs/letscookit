import 'package:letscookit/utilities/lista_ingredientes.dart';

import 'package:letscookit/utilities/paso.dart';
import 'ingrediente.dart';
import 'etiqueta.dart';
import 'medida.dart';

class Receta {
  String _nombre;
  int _numPersonas;
  int _duracion;
  bool _realizada;
  List<Paso> _pasos; // * Tiene que estar ordenada
  Map<Ingrediente, Medida> _ingredientes;
  List<Etiqueta> _etiquetas;
  ListaIngredientes _listaIngredientes;

  //Constructor
  Receta(this._nombre, this._numPersonas, this._duracion)
      : _realizada = false,
        _pasos = [],
        _ingredientes = {},
        _listaIngredientes = ListaIngredientes(),
        _etiquetas = [];
  //_listaIngredientes = new ListaIngredientes();

  // setters
  void setNombre(String nombre) => this._nombre = nombre;
  void setNumPersonas(int numPersonas) => this._numPersonas = numPersonas;
  void setRealizada(bool realizada) => this._realizada = realizada;

  // getters
  String get nombre => _nombre;
  int get numPersonas => _numPersonas;
  bool get realizada => _realizada;

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

  // File getImagen(int i) => imagen[i];

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
    if (index == -1) {
      Ingrediente ingrediente = Ingrediente(nombre);
      Medida medida = Medida(cantidad, unidad);
      _listaIngredientes.add(ingrediente);
      _ingredientes[ingrediente] = medida;
    }
  }

  //void addImagen(File imagen) => imagenes.add(imagen);

  //void empezarReceta() => empiesa;

}
