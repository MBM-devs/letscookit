//igual q receta

class Paso {
  int _numero;
  String _descripcion;

  Paso(this._numero, this._descripcion);

  //getters
  int get numero => _numero;
  String get descripcion => _descripcion;

  //setters
  void set numero(int numero) => this._numero = numero;
  void set descripcion(String descripcion) => this._descripcion = descripcion;
}
