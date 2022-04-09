import 'receta.dart';

class MenuDiario {
  List<Receta> desayunos;
  List<Receta> comidas;
  List<Receta> cenas;
  //Date dia;

  MenuDiario(this.desayunos, this.comidas, this.cenas);

  void addDesayuno(Receta desayuno) => desayunos.add(desayuno);
  void addComida(Receta comida) => comidas.add(comida);
  void addCena(Receta cena) => cenas.add(cena);

  void removeDesayuno(Receta desayuno) => desayunos.remove(desayuno);
  void removeComida(Receta comida) => desayunos.remove(comida);
  void removeCena(Receta cena) => desayunos.remove(cena);

  //Date getDia();
  //Date setDia(dia) => this.dia = dia;
}
