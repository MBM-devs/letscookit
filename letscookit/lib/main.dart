import 'dart:io';

import 'package:flutter/material.dart';
import 'package:letscookit/pages/recipe_list_view.dart';
import 'package:letscookit/pages/recipe_view.dart';
import 'pages/home.dart';
import 'pages/bookmark.dart';
import 'pages/create_recipe.dart';
import 'pages/search.dart';
import 'pages/shoppingBasket.dart';
import 'package:letscookit/utilities/ingrediente.dart';
import 'package:letscookit/utilities/libro_recetas.dart';
import 'package:letscookit/utilities/lista_ingredientes.dart';
import 'package:letscookit/utilities/lista_compra.dart';
import 'package:letscookit/utilities/lista_receta.dart';
import 'package:letscookit/utilities/medida.dart';
import 'package:letscookit/utilities/receta.dart';
import 'config/palette.dart';

void main() {
  Receta receta = Receta("Pollo al limón", 2, 60);
  ListaIngredientes l1 = ListaIngredientes();
  LibroRecetas libro = LibroRecetas();

  libro.misRecetas.add(receta);
  libro.misRecetas.add(Receta("Pollo al Curry", 4, 120));
  // libro2.misRecetas.add(Receta("Esparragos", 4));

  // receta.crearIngrediente(2, "Rodajas", "Limón");
  // receta.crearIngrediente(1, "", "Pollo");
  // receta.crearIngrediente(1, "pizca", "Sal");

  // receta.ingredientes.forEach((key, value) =>
  //     print('${key.nombre}: ${value.cantidad} ${value.unidad} '));
  libro.misRecetas.forEach((receta) {
    print(receta.nombre);
    print(receta.numPasos);
  });

  l1.forEach((ingrediente) {
    print(ingrediente.nombre);
  });

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _paginaActual = 0;
  final List<Widget> _paginas = [
    Home(),
    Bookmark(),
    CreateRecipe(),
    // RecipeView(),
    Search(),
    shoppingBasket()
  ];
  final List<String> _titulos = [
    "Mis Recetas",
    "Listas de recetas",
    "Crear receta",
    "Buscar",
    "Lista de la compra"
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Palette.mainBlue,
      ),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          title: Text(_titulos[_paginaActual]),
        ),
        body: SingleChildScrollView(child: _paginas[_paginaActual]),
        bottomNavigationBar: SizedBox(
          height: 60,
          child: BottomNavigationBar(
            // selectedIconTheme: IconThemeData(color: Palette.mainBlue[200]),
            // unselectedIconTheme: IconThemeData(color: Palette.mainBlue),
            type: BottomNavigationBarType.fixed,
            currentIndex: _paginaActual,
            onTap: (index) {
              setState(() {
                _paginaActual = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                label: "",
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.menu_book_rounded), label: ""),
              BottomNavigationBarItem(icon: Icon(Icons.add_rounded), label: ""),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search_rounded), label: ""),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_basket_rounded), label: ""),
            ],
          ),
        ),
      ),
    );
  }
}
