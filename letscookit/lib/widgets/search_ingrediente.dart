import 'package:flutter/material.dart';
import 'package:letscookit/config/palette.dart';
import 'package:letscookit/utilities/ingrediente.dart';
import 'package:letscookit/utilities/lista_compra.dart';
import 'package:letscookit/utilities/lista_ingredientes.dart';
import 'package:searchfield/searchfield.dart';

class SearchBarIngrediente extends StatefulWidget {
  ListaIngredientes _listaIngredientes;
  ListaCompra _listaCompra;
  SearchBarIngrediente(this._listaIngredientes, this._listaCompra, {Key? key})
      : super(key: key);
  @override
  State<SearchBarIngrediente> createState() => _SearchBarIngredienteState();
}

class _SearchBarIngredienteState extends State<SearchBarIngrediente> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: SearchField<Ingrediente>(
        suggestions: widget._listaIngredientes.lista
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
              color: Palette.mainBlue.shade400,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        maxSuggestionsInViewPort: 6,
        itemHeight: 50,
        suggestionsDecoration: BoxDecoration(
          color: Palette.mainBlue.shade400,
          borderRadius: BorderRadius.circular(10),
        ),
        onSuggestionTap: (value) {
          setState(() {
            widget._listaCompra.add(value.item!);
          });
        },
      ),
    );
  }
}
