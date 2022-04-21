import 'package:flutter/material.dart';
import 'package:letscookit/config/palette.dart';
import 'package:letscookit/pages/recipe_list.dart';
import 'package:letscookit/utilities/libro_recetas.dart';
import 'package:letscookit/utilities/lista_receta.dart';

import '../utilities/receta.dart';
import 'create_list.dart';

class Bookmark extends StatefulWidget {
  Bookmark({Key? key}) : super(key: key);

  @override
  State<Bookmark> createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> {
  List<Receta> lista = [];
  LibroRecetas libroRecetas = LibroRecetas();
  ListaReceta listaRecetas = ListaReceta("Mi Lista");
  String _receta =
      "Receta1"; //Tiene que estar inicializado al valor de alguno de los items
  Receta receta1 = new Receta("Pollo al limon", 2, 3);
  @override
  Widget build(BuildContext context) {
    //libroRecetas.add(listaRecetas);
    return Column(
      children: [
        ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: libroRecetas.length(),
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: ListTile(
                  title: Text(libroRecetas.get(index).nombre),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecipeList(libroRecetas.get(
                            index)), //tendria que llevar a la pagina RecipeList del indice correspondiente
                      ),
                    );
                  },
                  leading: CircleAvatar(
                      //backgroundImage: AssetImage('assets/elfary.jpg'),
                      ),
                ),
              );
            }),
        const SizedBox(
          height: 10.0,
          width: 1.0,
        ),
        FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Palette.mainGreen,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateList(),
                ));
            setState(() {});
          },
        ),
      ],
    );
  }

  //Metodo que redirige al usuario a la receta que ha seleccionado del menu desplegable
  void viewReceta(String? selectedReceta) {
    //se le pasa Receta receta
    if (selectedReceta is String) {
      setState(() {
        _receta = selectedReceta;
      });
    }
  }
  /*
  void viewReceta(Receta? selectedReceta){ //se le pasa Receta receta
    if(selectedReceta is Receta){
      setState(() {
        _receta = selectedReceta;
      });
    }
  }
  */
}
