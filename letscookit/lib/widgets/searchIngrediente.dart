import 'package:flutter/material.dart';
import 'package:letscookit/utilities/ingrediente.dart';
import 'package:letscookit/utilities/lista_Ingredientes.dart';
import 'package:searchfield/searchfield.dart';

class SearchIngrediente extends StatefulWidget {
  SearchIngrediente({Key? key}) : super(key: key);

  @override
  State<SearchIngrediente> createState() => _SearchIngredienteState();
}

class _SearchIngredienteState extends State<SearchIngrediente> {
  ListaIngredientes listaIngredientes;
  List<String> listaIngredientesString = [];

  _SearchIngredienteState() : listaIngredientes = ListaIngredientes() {
    listaIngredientes.add(Ingrediente("pimientos"));
    listaIngredientes.add(Ingrediente("aguacate"));
    listaIngredientesString = listaIngredientes.listToString();
  }

  @override
  Widget build(BuildContext context) {
    String? _selectedItem;
    return Container(
      child: SearchField<Ingrediente>(
        suggestions: listaIngredientes.lista
            .map((e) => SearchFieldListItem<Ingrediente>(e.nombre, item: e))
            .toList(),
        hint: 'Buscar ingrediente...',
        searchInputDecoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blueGrey.shade200,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: Colors.blue.withOpacity(0.8),
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        maxSuggestionsInViewPort: 6,
        itemHeight: 50,
        suggestionsDecoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        onTap: (value) {
          setState(() {
            _selectedItem = value as String?;
          });

          print(value);
        },
      ),
    );
  }
}
