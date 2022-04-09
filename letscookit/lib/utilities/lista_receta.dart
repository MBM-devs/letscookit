import 'receta.dart';

class ListaReceta {
  String _nombre;
  List<Receta> _recetas;

  ListaReceta(this._nombre) : _recetas = [];

  String get nombre => _nombre;
  void set nombre(String nombre) => this._nombre = nombre;

  void add(Receta receta) => _recetas.add(receta);
  void remove(Receta receta) => _recetas.remove(receta);
}
