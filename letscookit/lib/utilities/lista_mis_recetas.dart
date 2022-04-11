import 'package:letscookit/utilities/lista.dart';
import 'package:letscookit/utilities/lista_receta.dart';

import 'receta.dart';

/// EN PRINCIPIO NO HARIA FALTA
class MisRecetas extends ListaReceta {
  MisRecetas._privateConstructor() : super("Mis Recetas");

  static final MisRecetas _instance = MisRecetas._privateConstructor();

  factory MisRecetas() {
    return _instance;
  }
}
