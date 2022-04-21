import 'dart:io';

import 'package:flutter/material.dart';
import 'package:letscookit/pages/create_list.dart';
import 'package:letscookit/pages/recipe_list.dart';

import 'package:letscookit/pages/recipe_view.dart';
import 'package:letscookit/widgets/my_scaffold.dart';
import 'pages/home.dart';
import 'pages/bookmark.dart';
import 'pages/create_recipe.dart';
import 'pages/search.dart';
import 'pages/shopping_basket.dart';
import 'package:letscookit/utilities/ingrediente.dart';
import 'package:letscookit/utilities/libro_recetas.dart';
import 'package:letscookit/utilities/lista_ingredientes.dart';
import 'package:letscookit/utilities/lista_compra.dart';
import 'package:letscookit/utilities/lista_receta.dart';
import 'package:letscookit/utilities/medida.dart';
import 'package:letscookit/utilities/receta.dart';
import 'config/palette.dart';

void main() {
  Receta receta = Receta("Pollo al limón", 2, 60, 'assets/PolloAlLimon.jpeg');
  receta.crearPaso("Calentar Pollo");
  receta.crearPaso("Poner limon");
  receta.crearPaso("Poner Sal");
  // receta.crearPaso("Comer");

  ListaIngredientes l1 = ListaIngredientes();
  LibroRecetas libro = LibroRecetas();

  libro.misRecetas.add(receta);
  libro.misRecetas
      .add(Receta("Pollo al Curry", 4, 120, 'assets/pollo-al-curry.jpeg'));
  // libro2.misRecetas.add(Receta("Esparragos", 4));

  receta.crearIngrediente(2, "Rodajas", "Limón");
  receta.crearIngrediente(1, "", "Pollo");
  receta.crearIngrediente(1, "pizca", "Sal");

  // receta.ingredientes.forEach((key, value) =>
  //     print('${key.nombre}: ${value.cantidad} ${value.unidad} '));

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
    Search(),
    ShoppingBasket(),
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
      initialRoute: '/',
      onGenerateRoute: (settings) {
        // Handle '/'
        switch (settings.name) {
          case '/crear_receta':
            return MaterialPageRoute(
                builder: (context) =>
                    MyScaffold(CreateRecipe(), "Crear Receta"));
        }

        // Handle '/details/:id'
        var uri = Uri.parse(settings.name!);
        if (uri.pathSegments.length == 2) {
          if (uri.pathSegments.first == 'receta') {
            int id = int.parse(uri.pathSegments[1]);
            return MaterialPageRoute(
                builder: (context) =>
                    RecipeView(LibroRecetas().misRecetas.get(id)));
          }
          if (uri.pathSegments.first == 'lista') {
            int id = int.parse(uri.pathSegments[1]);
            return MaterialPageRoute(
                builder: (context) => RecipeList(LibroRecetas().get(id)));
          }
        }

        return MaterialPageRoute(
            builder: (context) => RecipeView(LibroRecetas().misRecetas.get(0)));
      },
      title: "Let's Cook It",
      home: MyScaffold(
        _paginas[_paginaActual],
        _titulos[_paginaActual],
        child: SizedBox(
          height: 60,
          child: BottomNavigationBar(
            // selectedIconTheme: IconThemeData(color: Palette.mainBlue[200]),
            // unselectedIconTheme: IconThemeData(color: Palette.mainBlue),
            type: BottomNavigationBarType.fixed,
            currentIndex: _paginaActual,
            onTap: (value) {
              setState(() {
                _paginaActual = value;
              });
            },
            items: const [
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
