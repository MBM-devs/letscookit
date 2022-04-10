import 'paso.dart';
import 'ingrediente.dart';
import 'etiqueta.dart';
import 'medida.dart';

class Receta {
  String _nombre;
  int _numPersonas;
  bool _realizada;
  List<Paso> _pasos; // * Tiene que estar ordenada
  Map<Ingrediente, Medida> _ingredientes;
  List<Etiqueta> _etiquetas;
  // List<File> imagenes;

  //Constructor
  Receta(this._nombre, this._numPersonas)
      : _realizada = false,
        _pasos = [],
        _ingredientes = new Map(),
        _etiquetas = [];

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

  Map<Ingrediente, Medida> get ingredientes => _ingredientes;

  Paso getPaso(int i) => _pasos[i];
  Etiqueta getEtiqueta(int i) => _etiquetas[i];

  // File getImagen(int i) => imagen[i];

  void addIngrediente(Medida medida, Ingrediente ingrediente) {
    _ingredientes[ingrediente] = medida;
  }

  void addEtiqueta(Etiqueta etiqueta) => _etiquetas.add(etiqueta);
  void _addPaso(Paso paso) => _pasos.add(paso);

  /// Crea un paso y lo añade al array
  void nuevoPaso(String descripcion) {
    Paso paso = new Paso(_pasos.length, descripcion);
    this._addPaso(paso);
  }

  //void addImagen(File imagen) => imagenes.add(imagen);

  //void empezarReceta() => empiesa;

}
