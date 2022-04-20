import 'package:flutter/material.dart';
import 'package:letscookit/config/palette.dart';
import 'package:letscookit/utilities/ingrediente.dart';
import 'package:letscookit/utilities/lista_Ingredientes.dart';
import 'package:letscookit/utilities/lista_compra.dart';

class IngredienteComprar extends StatefulWidget {
  Ingrediente _ingrediente;
  IngredienteComprar(this._ingrediente, {Key? key}) : super(key: key);

  @override
  State<IngredienteComprar> createState() => _IngredienteComprarState();
}

class _IngredienteComprarState extends State<IngredienteComprar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          CheckboxListTile(
            activeColor: Palette.mainBlue.shade500,
            dense: true,
            title: Text(widget._ingrediente.nombre),
            value: ListaCompra().getCheck(widget._ingrediente),
            onChanged: (value) {
              setState(() {
                ListaCompra().setCheck(widget._ingrediente, value!);
                print(
                    "Ingrediente: ${widget._ingrediente.nombre}, ${ListaCompra().getCheck(widget._ingrediente)}");
              });
            },
          ),
        ],
      ),
    );
  }
}
