import 'package:flutter/material.dart';
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

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => setState(() => lista.add({Ingrediente("Ingrediente ${++_cont}") : false}))
      ),
      body: ListView.builder(
          itemCount: lista.length,
          itemBuilder: (BuildContext context, int index){
            return Card(
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    CheckboxListTile(
                      activeColor: Color.fromARGB(255, 52, 160, 164),
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
    );

    /*return Scaffold(
      body: ListView.builder(
          itemCount: lista.length(),
          itemBuilder: (BuildContext context, int index){
            return Card(
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    CheckboxListTile(
                      activeColor: Color.fromARGB(255, 52, 160, 164),
                      dense: true,
                      title: Text(lista.get(index).nombre),
                      value: lista.get(index).isChecked,
                      onChanged: (bool? value){
                        setState(() {
                          lista.get(index).isChecked = value;
                        });
                      },
                    )
                  ],
                ),
              ),
            );
          }),
    );*/
    /*
    Ingrediente pollo = new Ingrediente("Pollo");
    Ingrediente pan = new Ingrediente("Pan");
    Ingrediente ajo = new Ingrediente("Ajo");
    Map<Ingrediente, bool> mapaCompra = {
      pollo : false,
      pan : true,
      ajo : false
    };
    int _cont = 0;
    */

    /*Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Color.fromARGB(255, 52, 160, 164);
    }*/
  /*
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => setState(() => mapaCompra.addEntries(
            [MapEntry(Ingrediente("Ingrediente ${_cont++}"), false)]
        )),
      ),
      body: ListView(
        children: mapaCompra.keys.map(
              (ingrediente) => CheckboxListTile(
                title: Text(ingrediente.nombre),
                secondary: Text(
                    "#${++_cont}",
                    textAlign: TextAlign.center,
                ),
                controlAffinity: ListTileControlAffinity.trailing,
                value: mapaCompra[ingrediente],
                onChanged: (bool? value){
                  setState(() {
                    mapaCompra[ingrediente] = value!;
                    print("El valor de ${ingrediente.nombre} es ${mapaCompra[ingrediente]}");
                  });
                },
                activeColor: Color.fromARGB(255, 52, 160, 164),
                checkColor: Colors.white,
          ),
        ).toList(),
      ),
    );
  */
  }
}
