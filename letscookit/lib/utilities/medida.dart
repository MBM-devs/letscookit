class Medida {
  int _cantidad;
  String _unidad;

  Medida(this._cantidad, this._unidad);

  int get cantidad => _cantidad;
  String get unidad => _unidad;
  set unidad(String unidad) => _unidad = unidad;
  set cantidad(int cantidad) => _cantidad = cantidad;
}
