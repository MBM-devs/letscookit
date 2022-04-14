import 'package:flutter/material.dart';
import 'package:letscookit/utilities/ingrediente.dart';

import '../utilities/lista_Ingredientes.dart';
import '../utilities/lista_compra.dart';
import '../utilities/receta.dart';

class shoppingBasket extends StatefulWidget {
  shoppingBasket({Key? key}) : super(key: key);

  @override
  State<shoppingBasket> createState() => _shoppingBasketState();
}

class _shoppingBasketState extends State<shoppingBasket> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Ingrediente pollo = new Ingrediente("Pollo");
    Ingrediente pan = new Ingrediente("Pan");
    Ingrediente ajo = new Ingrediente("Ajo");
    Map<Ingrediente, bool> mapaCompra = {
      pollo : false,
      pan : true,
      ajo : false
    };
    //Lista de maps
    List<Map<Ingrediente, bool>> listaCompra = [
      {pollo : false},
      {pan : true}
    ];
    int _cont = 0;

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

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => setState(() => mapaCompra.addEntries([MapEntry(Ingrediente("${_cont++}"), false)])),
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
                  });
                },
                activeColor: Color.fromARGB(255, 52, 160, 164),
                checkColor: Colors.white,
          ),
        ).toList(),
      ),
    );

    /*return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: ingredientes.keys.map((ingrediente) {
        return new CheckboxListTile(
          checkColor: Colors.white,
          //fillColor: MaterialStateProperty.resolveWith(getColor),
          title: new Text(ingrediente.nombre),
          value: ingredientes[ingrediente],
          onChanged: (bool? value) {
            setState(() {
              ingredientes[ingrediente] = value!;
            });
        },
      );
    }).toList(),
    ); */
  }
}
