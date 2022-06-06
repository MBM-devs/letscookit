import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:letscookit/bd/paso_bd.dart';

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


//La clase Paso obtiene los datos de la clase PasoDB, que es la que los obtiene de la base de datos
/* class Paso {} */
