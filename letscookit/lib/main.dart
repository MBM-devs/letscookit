import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:letscookit/pages/login.dart';
import 'package:letscookit/pages/recipe_list.dart';
import 'package:letscookit/pages/recipe_view.dart';
import 'package:letscookit/pages/splash.dart';
import 'package:letscookit/utilities/generar_recetas.dart';
import 'package:letscookit/widgets/my_scaffold.dart';
import 'pages/home.dart';
import 'pages/bookmark.dart';
import 'pages/create_recipe.dart';
import 'pages/search.dart';
import 'pages/shopping_basket.dart';
import 'package:letscookit/utilities/libro_recetas.dart';
import 'config/palette.dart';

void main() {
  GenerarRecetas().obtenerRecetas();
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
      home: Splash(),
      /*
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
      */
    );
  }
}
