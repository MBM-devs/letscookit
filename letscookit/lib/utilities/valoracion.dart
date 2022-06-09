import '../bd/valoracion_bd.dart';

class Valoracion {

  List<int> valoraciones = [];
  int idReceta;

  Valoracion(this.idReceta);

  Future<double> getValoracion() async{
    List<ValoracionBD> valoracionesBD = await ValoracionBD.getValoraciones(idReceta.toString());

    int media = 0;

    for(int i=0; i<valoracionesBD.length; i++){
      valoraciones.add(valoracionesBD[i].valoracion);
      media += valoraciones[i];
    }

    return media/valoraciones.length;

  }

}