import '../bd/usuario_bd.dart';

class Usuario {
  int _id;
  String _username;
  String _password;

  Usuario()
      : _username = "",
        _password = "",
        _id = -1;

  int get id => _id;
  String get username => _username;
  String get password => _password;

  //Comprueba si se ha iniciado la sesion
  bool sesionIniciada() {
    return _id >= 0;
  }

  //El usuario inicia sesion
  Future<bool> iniciarSesion(String username, String password) async {
    _username = username;
    _password = password;
    _id = await UsuarioBD().iniciarSesion(username, password);
    return sesionIniciada();
  }
}
