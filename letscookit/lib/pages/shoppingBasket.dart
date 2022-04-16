import 'package:flutter/material.dart';
import 'package:letscookit/config/palette.dart';
import 'package:letscookit/utilities/ingrediente.dart';
import '../utilities/lista_compra.dart';


class shoppingBasket extends StatefulWidget {
  shoppingBasket({Key? key}) : super(key: key);

  @override
  State<shoppingBasket> createState() => _shoppingBasketState();
}

class _shoppingBasketState extends State<shoppingBasket> {

  ListaCompra listaCompra = ListaCompra();
  List<Map<Ingrediente, bool>> lista = [
    {Ingrediente("Pollo") : false},
    {Ingrediente("Pan") : false},
    {Ingrediente("Ajo") : false}
  ];
  int _cont = 0;
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: lista.length,
            itemBuilder: (BuildContext context, int index){
              return Card(
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      CheckboxListTile(
                        activeColor: Palette.mainBlue,
                        dense: true,
                        title: Text(lista[index].keys.first.nombre),
                        value: lista[index].values.first,
                        onChanged: (bool? value) {
                          setState(() {
                            lista[index].update(lista[index].keys.first, (value) => !value);
                            print("Ingrediente: ${lista[index].keys.first.nombre}, ${lista[index].values.first}");
                          });
                        },
                      )
                    ],
                  ),
                ),
              );
            }
        ),
        FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Palette.mainBlue.shade200,
            onPressed: () => setState(() => lista.add({Ingrediente("Ingrediente ${++_cont}") : false}))
        ),
      ],

    );
  }
}
