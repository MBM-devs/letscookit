import 'dart:convert';
import 'package:http/http.dart' as http;

class Usuario {
  final String nombre;
  final String email;
  final String password;

  static String _direccionBD = 'clados.ugr.es'; //URL del servidor web

  Usuario(this.nombre, this.email, this.password);

  Map<String, dynamic> toJson() => {
    'nombre': nombre,
    'email': email,
    'password': password,
  };

  Usuario.fromJson(Map<String, dynamic> json)
    :   nombre = json["nombre"],
        email = json["email"],
        password = json["password"];

  //GET
  static Future<Usuario> getUsuario(String nombre) async {
    final response = await http.get(Uri.https(_direccionBD, '/DS1_2/api/v1/users' + nombre));

    //Si la respuesta no da código de error (200 es de confirmacion)
    if(response.statusCode == 200){
      return Usuario.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Fallo al obtener el usuario");
    }

  }

}