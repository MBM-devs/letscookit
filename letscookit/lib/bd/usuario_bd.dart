import 'dart:convert';
import 'package:http/http.dart' as http;


class UsuarioBD {
  late int _id;
  late String _username;
  late String _email;

  static const String _baseAddress = 'clados.ugr.es';
  static const String _applicationName = 'DS1_2/api/v1/login';

  UsuarioBD()
      : _id = -1,
        _username = "",
        _email = "";

  Future<int> iniciarSesion(String username, String password) async {
    //Hace post al servidor con los datos del usuario
    print("Usuario: "+username+", Contraseña: "+password);
    UsuarioBD usuario = await postLogin(username, password);
    print(usuario.toJson());
    return usuario._id;
  }

  Map<String, dynamic> toJson() => {
        'id': _id,
        'username': _username,
        'email': _email,
      };

  UsuarioBD.fromJson(Map<String, dynamic> json) {
    if (json['error'] != null) {
      _id = -1;
      _username = "";
      _email = "";
    } else {
      _id = json['id'];
      _username = json['username'];
      _email = json['email'];
    }
  }

  static Future<UsuarioBD> postLogin(String username, String password) async {
    final response = await http.post(
      Uri.https(_baseAddress, _applicationName),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );
    print(response.statusCode.toString());
    if (response.statusCode == 200) {
      return UsuarioBD.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to login');
    }
  }
}
