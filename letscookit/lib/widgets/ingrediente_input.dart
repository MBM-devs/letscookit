import 'package:flutter/material.dart';
import 'package:letscookit/utilities/ingrediente.dart';

class IngredienteInput extends StatefulWidget {
  int _index;
  List<String> _lista;

  IngredienteInput(this._index, this._lista, {Key? key}) : super(key: key);

  @override
  State<IngredienteInput> createState() => _IngredienteInputState();
}

class _IngredienteInputState extends State<IngredienteInput> {
  TextEditingController _cantidadIngrediente = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _cantidadIngrediente,
            decoration: const InputDecoration(
              icon: Icon(Icons.bakery_dining_rounded),
              hintText: "Numero",
              labelText: 'Cantidad',
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: TextField(
            decoration: InputDecoration(hintText: "Unidad"),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: TextField(
            decoration: InputDecoration(hintText: "Ingrediente"),
          ),
        )
      ],
    );
  }
}
