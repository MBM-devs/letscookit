import 'paso.dart';
import 'ingrediente.dart';
import 'etiqueta.dart';

class Receta {
  String nombre;
  int numPersonas;
  bool realizada;
  List<Paso> pasos; // * Tiene que estar ordenada
  // Map<Ingrediente, Pair<cantidad, ud>> ingredientes; Seria un map de ingrediente y un pair de cantidad y unidad
  // Map<Ingrediente, Map<double, String>>
  // ingredientes; Seria un map de ingrediente y un pair de cantidad y unidad
  List<Etiqueta> etiquetas;
  // List<File> imagenes;

  //Constructor
  Receta(this.nombre, this.numPersonas)
      : realizada = false,
        pasos = [],
        etiquetas = [];

  // setters
  void setNombre(String nombre) => this.nombre = nombre;
  void setNumPersonas(int numPersonas) => this.numPersonas = numPersonas;
  void setRealizada(bool realizada) => this.realizada = realizada;

  // getters
  String getNombre() => nombre;
  int getNumPersonas() => numPersonas;
  bool getRealizada() => realizada;
  Paso getPaso(int i) => pasos[i];
  Etiqueta getEtiqueta(int i) => etiquetas[i];
  // Ingrediente getIngrediente(int i) => ingredientes[i];
  // File getImagen(int i) => imagen[i];

  //void addPaso(Paso paso) => pasos.add(paso);
  // TODO: Añadir cantidad y ud
  //void addIngrediente(Ingrediente ingrediente) => ingredientes.add(ingrediente);
  void addEtiqueta(Etiqueta etiqueta) => etiquetas.add(etiqueta);
  void addPaso(Paso paso) => pasos.add(paso);
  //void addImagen(File imagen) => imagenes.add(imagen);

  //void empezarReceta() => empiesa;

}
