import 'package:flutter/material.dart';

//Pagina Home
class PaginaHome extends StatelessWidget {
  const PaginaHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(30),
              color: Colors.red,
              child: Text('Illo que dise loko'),
            ),
            Container(
              padding: EdgeInsets.all(20),
              color: Colors.amber,
              child: Text(' Po na mano aqui de demaziao'),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.all(20.0),
          color: Colors.blue,
          child: Text('La Mandanga'),
        ),
        Container(
          padding: EdgeInsets.all(30.0),
          color: Colors.deepOrange,
          child: Text('Torito guapo'),
        ),
        Container(
          padding: EdgeInsets.all(60.0),
          color: Colors.green,
          child: Text('El Fary'),
        ),
      ],
    );
  }
}
