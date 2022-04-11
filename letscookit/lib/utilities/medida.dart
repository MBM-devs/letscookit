class Medida {
  int _cantidad;
  String _unidad;

  Medida(this._cantidad, this._unidad);

  int get cantidad => _cantidad;
  String get unidad => _unidad;

  void setCantidad(int cantidad) => this._cantidad = cantidad;
  void setUnidad(String unidad) => this._unidad = unidad;
}
