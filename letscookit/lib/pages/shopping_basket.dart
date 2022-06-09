import 'package:flutter/material.dart';
import 'package:letscookit/bd/ingredientes_bd.dart';
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
              ListaCompra().add(value.item!);
              setState(() {});
              _searchController.clear();
              FocusScope.of(context).unfocus();
            },
            onSubmit: (value) {
              int indice = ListaIngredientes().buscaIngrediente(value);
              if (indice == -1 && value != "") {
                ListaIngredientes().add(Ingrediente(value));
                indice = ListaIngredientes().lista.length - 1;
              }
              if (value != "") {
                ListaCompra().add(ListaIngredientes().get(indice));
              }
              setState(() {});
              _searchController.clear();
              FocusScope.of(context).unfocus();
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
                        "¿Seguro que quiere borrar todos los ingredientes comprados?"),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.grey[700],
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 5.0),
                                textStyle: TextStyle(color: Colors.grey[200]),
                              ),
                              onPressed: (() {
                                setState(() {});
                                Navigator.pop(context);
                              }),
                              child: Text("Cancelar")),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red[400],
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 5.0),
                                textStyle: const TextStyle(color: Colors.black),
                              ),
                              onPressed: (() {
                                ListaCompra().borrarComprados();
                                setState(() {});
                                Navigator.pop(context);
                              }),
                              child: Text("Si")),
                        ],
                      ),
                    ],
                  ),
                );
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
