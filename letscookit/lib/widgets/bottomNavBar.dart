import 'package:flutter/material.dart';

class Navbar extends StatefulWidget {
  Navbar({Key? key}) : super(key: key);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  //TODO: lista de widgets para hacer las paginas
  int _paginaActual = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _paginaActual,
      onTap: (index) {
        setState(() {
          _paginaActual = index;
        });
      },
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.home), label: "", backgroundColor: Colors.blue),
        BottomNavigationBarItem(
            icon: Icon(Icons.book), label: "", backgroundColor: Colors.blue),
        BottomNavigationBarItem(
            icon: Icon(Icons.add), label: "", backgroundColor: Colors.blue),
        BottomNavigationBarItem(
            icon: Icon(Icons.search), label: "", backgroundColor: Colors.blue),
        BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket_rounded),
            label: "",
            backgroundColor: Colors.blue),
      ],
    );
  }
}
