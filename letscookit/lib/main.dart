import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/bookmark.dart';
import 'pages/receipt.dart';
import 'pages/search.dart';
import 'pages/shoppingBasket.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _paginaActual = 0;
  List<Widget> _paginas = [
    Home(),
    Bookmark(),
    Receipt(),
    Search(),
    shoppingBasket()
  ];
  List<String> _titulos = [
    "Página principal",
    "Listas de recetas",
    "Crear receta",
    "Buscar",
    "Lista de la compra"
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: Scaffold(
          appBar: AppBar(
            title: Text(_titulos[_paginaActual]),
          ),
          body: _paginas[_paginaActual],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _paginaActual,
            onTap: (index) {
              setState(() {
                _paginaActual = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "",
              ),
              BottomNavigationBarItem(icon: Icon(Icons.book), label: ""),
              BottomNavigationBarItem(icon: Icon(Icons.add), label: ""),
              BottomNavigationBarItem(icon: Icon(Icons.search), label: ""),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_basket_rounded), label: ""),
            ],
          )),
    );
  }
}
