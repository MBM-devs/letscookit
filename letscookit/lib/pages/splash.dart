import 'package:flutter/material.dart';
import 'package:letscookit/main.dart';
import 'package:letscookit/pages/login.dart';
import 'package:letscookit/pages/main_page.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    const d = Duration(seconds: 2);
    //se retarda d segundos en pasar de página
    Future.delayed(d, () {
      //pasa a la siguiente página y cierra esta
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) {
            return SingleChildScrollView(child: Login());
          },
        ),
        (route) => false,
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          horizontal: 50,
          vertical: MediaQuery.of(context).size.height / 3,
        ),
        child: Image.asset("assets/icono-letscookit-1.png"),
      ),
    );
  }
}
