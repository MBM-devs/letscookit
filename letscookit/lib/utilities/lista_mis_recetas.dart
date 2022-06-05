import 'package:letscookit/utilities/lista_receta.dart';
//FUERA
class MisRecetas extends ListaReceta {
  MisRecetas._privateConstructor() : super("Mis Recetas");

  static final MisRecetas _instance = MisRecetas._privateConstructor();

  factory MisRecetas() {
    return _instance;
  }
}
