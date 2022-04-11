import 'package:flutter/material.dart';

//Pagina 2
class Pagina2 extends StatelessWidget {
  const Pagina2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.red[600],
        child: Text(
          'Esta pagina es la segunda',
          style: TextStyle(
            fontSize: 50.0,
          ),
        ),
      ),
    );
  }
}