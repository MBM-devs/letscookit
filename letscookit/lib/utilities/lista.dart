import 'package:flutter/material.dart';

abstract class Lista {
  @protected
  List<dynamic> lista;
  String _nombre;

  Lista(this._nombre) : lista = [];

  String get nombre => _nombre;
  void set nombre(String nombre) => this._nombre = nombre;

  dynamic get(int i) {
    if (i >= 0 && i < lista.length) return lista[i];
  }

  int length() => lista.length;

  void add(dynamic elemento) {
    lista.add(elemento);
  }

  void forEach(void Function(dynamic) action) => lista.forEach(action);

  void remove(dynamic elemento) => lista.remove(elemento);
}
