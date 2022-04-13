import 'package:flutter/material.dart';
import 'package:letscookit/utilities/ingrediente.dart';

import '../utilities/lista_Ingredientes.dart';
import '../utilities/receta.dart';

class shoppingBasket extends StatefulWidget {
  shoppingBasket({Key? key}) : super(key: key);

  @override
  State<shoppingBasket> createState() => _shoppingBasketState();
}

class _shoppingBasketState extends State<shoppingBasket> {
  bool isChecked = false;
  int i = 0;


  @override
  Widget build(BuildContext context) {
    Receta receta = Receta("Pollo al limón", 2);
    ListaIngredientes l1 = ListaIngredientes();
    var map = {"ingrediente": "pollo", "check": "false"};
    l1.add(map);

    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Color.fromARGB(255, 52, 160, 164);
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            for (i = 0; i<l1.length(); i++) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(l1.get(i).toString()),
                  Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    value: l1.get(i)["check"], //Aqui habria que establecer a value al bool del map
                    onChanged: (bool? value) {
                      setState(() {
                        l1.get(i)["check"] = value!;
                      });
                    },
                  ),
                ],
              )
            ]
          ],
        )
      ],
    );
  }
}
