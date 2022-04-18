import 'package:flutter/material.dart';
import 'package:letscookit/config/palette.dart';
import 'package:letscookit/utilities/ingrediente.dart';
import '../utilities/lista_compra.dart';
import '../utilities/lista_Ingredientes.dart';
import 'package:searchfield/searchfield.dart';

class shoppingBasket extends StatefulWidget {
  shoppingBasket({Key? key}) : super(key: key);

  @override
  State<shoppingBasket> createState() => _shoppingBasketState();
}

class _shoppingBasketState extends State<shoppingBasket> {
  ListaCompra listaCompra = ListaCompra();
  ListaIngredientes listaIngredientes = ListaIngredientes();
  int _cont = 0;
  @override
  Widget build(BuildContext context) {
    listaIngredientes.add(Ingrediente("pimientos"));
    listaIngredientes.add(Ingrediente("aguacate"));

    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10.0),
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
                if (!listaCompra.existeIngrediente(value.item!))
                  listaCompra.add({value.item!: false});
              });
            },
          ),
        ),
        ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: listaCompra.length(),
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      CheckboxListTile(
                        activeColor: Palette.mainBlue.shade500,
                        dense: true,
                        title:
                            Text(listaCompra.get(_cont - 1).keys.first.nombre),
                        value: listaCompra.get(_cont - 1).values.first,
                        onChanged: (bool? value) {
                          setState(() {
                            listaCompra.get(_cont - 1).update(
                                listaCompra.get(_cont - 1).keys.first,
                                (value) => !value);
                            print(
                                "Ingrediente: ${listaCompra.get(_cont - 1).keys.first.nombre}, ${listaCompra.get(_cont - 1).values.first}");
                          });
                        },
                      )
                    ],
                  ),
                ),
              );
            }),
        FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Palette.mainBlue.shade200,
            onPressed: () => setState(() => {})),
      ],
    );
  }
}
