import 'lista_receta.dart';
import 'receta.dart';

//FUERA

class MenuDiario {
  ListaReceta _desayuno;
  ListaReceta _comida;
  ListaReceta _cena;

  /// Constructor sin parámetros: inicializa a vacío las listas
  MenuDiario()
      : _desayuno = ListaReceta("Desayuno"),
        _comida = ListaReceta("Comida"),
        _cena = ListaReceta("Cena");

  /// Añade una receta a la lista de Desayuno
  void addDesayuno(Receta receta) => _desayuno.add(receta);

  /// Añade una receta a la lista de Comida
  void addComida(Receta receta) => _comida.add(receta);

  /// Añade una receta a la lista de Cena
  void addCena(Receta receta) => _cena.add(receta);

  /// Elimina una receta de la lista de Desayuno
  void removeDesayuno(Receta receta) => _desayuno.remove(receta);

  /// Elimina una receta de la lista de Comida
  void removeComida(Receta receta) => _comida.remove(receta);

  /// Elimina una receta de la lista de Cena
  void removeCena(Receta receta) => _cena.remove(receta);
}
