import 'package:flutter/material.dart';
import 'package:letscookit/config/palette.dart';
import 'package:letscookit/utilities/ingrediente.dart';
import 'package:letscookit/widgets/ingrediente_lista.dart';
import '../utilities/lista_compra.dart';
import '../utilities/lista_ingredientes.dart';
import '../widgets/search_ingrediente.dart';
import 'package:searchfield/searchfield.dart';

class shoppingBasket extends StatefulWidget {
  shoppingBasket({Key? key}) : super(key: key);

  @override
  State<shoppingBasket> createState() => _shoppingBasketState();
}

class _shoppingBasketState extends State<shoppingBasket> {
  // ListaCompra _listaCompra = ListaCompra();
  ListaIngredientes _listaIngredientes = ListaIngredientes();
  int _cont = 0;
  @override
  Widget build(BuildContext context) {
    _listaIngredientes.add(Ingrediente("pimientos"));
    _listaIngredientes.add(Ingrediente("aguacate"));

    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10.0),
          child: SearchField<Ingrediente>(
            suggestions: _listaIngredientes.lista
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
                ListaCompra().add(value.item!);
              });
            },
          ),
        ),
        ..._getIngredientes(),
        FloatingActionButton(
            //TODO: Borrar los elementos con el checkbox marcado
            child: Icon(Icons.add),
            backgroundColor: Palette.mainBlue.shade200,
            onPressed: () => setState(() => {})),
      ],
    );
  }

  List<Widget> _getIngredientes() {
    List<Widget> ingredienteCard = [];

    for (var i = 0; i < ListaCompra().length(); i++) {
      ingredienteCard.add(
        IngredienteLista(ListaCompra().getIngrediente(i)),
      );
    }

    return ingredienteCard;
  }
}
