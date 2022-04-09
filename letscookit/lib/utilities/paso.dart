class Paso {
  int numero;
  String descripcion;

  Paso(this.numero, this.descripcion);

  //getters
  int getNumeor() => numero;
  String getDescripcion() => descripcion;

  //setters
  void setNumero(int numero) => this.numero = numero;
  void setDescripcion(String descripcion) => this.descripcion = descripcion;
}
