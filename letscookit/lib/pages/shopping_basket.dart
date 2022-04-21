import 'package:flutter/material.dart';
import 'package:letscookit/utilities/ingrediente.dart';
import 'package:letscookit/widgets/ingrediente_comprar.dart';
import '../utilities/lista_compra.dart';
import '../utilities/lista_ingredientes.dart';
import '../widgets/search_bar.dart';
import 'package:searchfield/searchfield.dart';

class ShoppingBasket extends StatefulWidget {
  ShoppingBasket({Key? key}) : super(key: key);

  @override
  State<ShoppingBasket> createState() => _ShoppingBasketState();
}

class _ShoppingBasketState extends State<ShoppingBasket> {
  int _cont = 0;
  TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10.0),
          child: SearchBar(
            controller: _searchController,
            hint: "Buscar o añadir nuevo ingrediente...",
            suggestions: ListaIngredientes()
                .lista
                .map((e) => SearchFieldListItem<Ingrediente>(e.nombre, item: e))
                .toList(),
            onSuggestionTap: (value) {
              setState(() {
                ListaCompra().add(value.item!);
                _searchController.clear();
              });
            },
            onSubmit: (value) {
              int indice = ListaIngredientes().buscaIngrediente(value);
              if (indice == -1) {
                ListaIngredientes().add(Ingrediente(value));
                indice = ListaIngredientes().length() - 1;
              }
              ListaCompra().add(ListaIngredientes().get(indice));
              _searchController.clear();
              setState(() {});
            },
          ),
          // controller.text = "";
        ),
        ..._getIngredientes(),
        ElevatedButton(
            child: const Text("Borrar comprados"),
            onPressed: () {
              if (ListaCompra().hayComprados()) {
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          content: const Text(
                              "¿Está seguro de borrar los ingredientes marcados?"),
                          actions: [
                            ElevatedButton(
                                onPressed: (() {
                                  setState(() {});
                                  Navigator.pop(context);
                                }),
                                child: Text("Cancelar")),
                            ElevatedButton(
                                onPressed: (() {
                                  ListaCompra().borrarComprados();
                                  setState(() {});
                                  Navigator.pop(context);
                                }),
                                child: Text("Si")),
                          ],
                        ));
              }
            }),
      ],
    );
  }

  List<Widget> _getIngredientes() {
    List<Widget> ingredienteCard = [];

    for (var i = 0; i < ListaCompra().length(); i++) {
      ingredienteCard.add(
        IngredienteComprar(ListaCompra().get(i)),
      );
    }

    return ingredienteCard;
  }
}
