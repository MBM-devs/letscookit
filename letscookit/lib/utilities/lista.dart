// ? clase template
class Lista {
  List<Object> lista;
  String nombre;

  Lista(this.nombre) : lista = [];
  void add(Object objeto) => lista.add(objeto);
  Object getObject(int i) => lista[i];
}
