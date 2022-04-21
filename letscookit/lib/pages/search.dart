import 'package:flutter/material.dart';
import 'package:letscookit/pages/create_recipe.dart';
import 'package:letscookit/pages/recipe_view.dart';
import 'package:letscookit/utilities/lista_mis_recetas.dart';
import 'package:searchfield/searchfield.dart';

import '../utilities/libro_recetas.dart';
import '../utilities/receta.dart';
import '../widgets/search_bar.dart';

class Search extends StatefulWidget {
  Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: SearchBar(
        controller: _searchController,
        hint: "Buscar receta...",
        suggestions: LibroRecetas()
            .misRecetas
            .lista
            .map((e) => SearchFieldListItem<Receta>(e.nombre, item: e))
            .toList(),
        onSuggestionTap: (value) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RecipeView(value.item),
              ));
          setState(() {});
          _searchController.clear();
        },
        // onSubmit: (value) {
        //   int index = LibroRecetas().misRecetas.buscaReceta(value);
        //   if (index != -1) {
        //     Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (context) =>
        //               RecipeView(LibroRecetas().misRecetas.get(index)),
        //         ));
        //   } else {
        //     Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (context) => CreateRecipe(),
        //         ));
        //   }

        //   setState(() {});
        //   _searchController.clear();
        // },
      ),
      // controller.text = "";
    );
  }
}
