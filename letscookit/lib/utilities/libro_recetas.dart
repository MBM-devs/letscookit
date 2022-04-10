// ? clase template
import 'lista_receta.dart';
import 'receta.dart';

class LibroRecetas {
  List<ListaReceta> _libroRecetas;

  LibroRecetas() : _libroRecetas = [];

  // Lista(this.nombre) : lista = [];
  void crearLista(String nombre) => _libroRecetas.add(new ListaReceta(nombre));
  void eliminarLista(ListaReceta lista) => _libroRecetas.remove(lista);

  void inicializarLibro() {
    ListaReceta misRecetas = new ListaReceta("Mis Recetas");
    _libroRecetas.add(misRecetas);
  }
  // Object getObject(int i) => lista[i];
}
