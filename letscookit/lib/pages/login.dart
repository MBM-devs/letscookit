// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:letscookit/config/palette.dart';
import 'package:http/http.dart' as http;
import 'package:letscookit/widgets/search_bar.dart';

import 'main_page.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isRememberMe = false;

  TextEditingController _nombreUsuario = TextEditingController();
  TextEditingController _password = TextEditingController();

  Widget buildUser() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Nombre de usuario',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            // ignore: prefer_const_literals_to_create_immutables
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0, 2),
              )
            ],
          ),
          height: 60,
          child: TextField(
            controller: _nombreUsuario,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.black87,
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.person,
                  color: Palette.mainBlue,
                ),
                hintText: 'Nombre de usuario',
                hintStyle: TextStyle(
                  color: Colors.black38,
                )),
          ),
        ),
      ],
    );
  }

  Widget buildPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Contraseña',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0, 2),
              )
            ],
          ),
          height: 60,
          child: TextField(
            controller: _password,
            obscureText: true,
            style: TextStyle(
              color: Colors.black87,
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.lock,
                  color: Palette.mainBlue,
                ),
                hintText: 'Contraseña',
                hintStyle: TextStyle(
                  color: Colors.black38,
                )),
          ),
        ),
      ],
    );
  }

  Widget buildForgotPassword() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () => print("Olvidé la contraseña presionado"),
        padding: EdgeInsets.only(right: 0),
        child: Text(
          'Olvidé mi contraseña',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget buildLoginBtn(context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: MediaQuery.of(context).size.width / 2,
      child: RaisedButton(
        elevation: 5,
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) {
                return MainPage();
              },
            ),
            (route) => false,
          );
          /* if (_nombreUsuario.text == '' || _password == '') {
            //Si los datos no son correctos, lo notifica y sigue en la pagina (he puesto que recargue por ahora)
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return Login();
                },
              ),
              (route) => false,
            );
          } else {
            //Si el usuario introducido es correcto, accede a la pagina
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return MainPage();
                },
              ),
              (route) => false,
            );
          }*/
        },
        padding: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.white,
        child: Text(
          'Iniciar sesión',
          style: TextStyle(
            color: Palette.mainBlue,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Widget buildRememberMe() {
    return Container(
      height: 20,
      child: Row(
        children: [
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: isRememberMe,
              checkColor: Palette.mainBlue,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  isRememberMe = value!;
                });
              },
            ),
          ),
          Text(
            'Recuérdame',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  //key con el estado para el acceso del usuario
  /* GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<bool> acceso({debug = false}) async {
    if (debug) {
      return peticion_acceso();
    } else {
      if (formKey.currentState.validate()) {
        return peticion_acceso();
      }
    }
  }

  Future<bool> peticion_acceso() async {
    String nombre = _nombreUsuario.text;
    String pass = _password.text;

    //Comprobar usuario y password

    //Conectarse a la api
    String url = "clados.ugr.es";
    final response =
        await http.post(url, body: {'username': nombre, 'password': pass});
  } */

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: GestureDetector(
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Palette.mainBlue.shade800.withOpacity(1.0),
                          Palette.mainBlue.shade700.withOpacity(1.0),
                          Palette.mainBlue.shade600.withOpacity(1.0),
                          Palette.mainBlue.shade500.withOpacity(1.0),
                          Palette.mainBlue.shade400.withOpacity(1.0),
                          Palette.mainBlue.shade200.withOpacity(1.0),
                          Palette.mainBlue.shade100.withOpacity(1.0),
                          Palette.mainBlue.shade50.withOpacity(1.0),
                        ]),
                  ),
                  child: SingleChildScrollView(
                    //physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 100,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Let's Cook It",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 30),
                        buildUser(),
                        SizedBox(height: 30),
                        buildPassword(),
                        //buildForgotPassword(),
                        //buildRememberMe(),
                        SizedBox(height: 30),
                        buildLoginBtn(context),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /*Widget build(BuildContext build){
    //Declaro dos variables para acceder mas facilmente a las dimensiones
    //double height = MediaQuery.of(context).size.height;
    //double width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(10.0),
          child: Text(
            'Login: ',
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 30.0,),
        Center(
          child: SizedBox(
            width: 300,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Nombre de usuario',
                suffixIcon: Icon(Icons.supervised_user_circle),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 30.0,),
        ElevatedButton(
            onPressed: (){},
            child: Text('Iniciar Sesión'),
        ),
      ],
    );
  }*/
}
