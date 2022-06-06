import 'package:flutter/material.dart';
import 'package:letscookit/utilities/ingrediente.dart';
import 'package:letscookit/utilities/medida.dart';

class IngredienteView extends StatefulWidget {
  Ingrediente _ingrediente;
  Medida _medida;
  IngredienteView(this._ingrediente, this._medida);

  @override
  _IngredienteViewState createState() => _IngredienteViewState();
}

class _IngredienteViewState extends State<IngredienteView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5),
      child: Row(
        children: [
          const Text(
            "- ",
            style: TextStyle(color: Colors.grey, fontSize: 15),
          ),
          const SizedBox(width: 5),
          Text(
            widget._medida.cantidad.toString(),
            style: const TextStyle(fontSize: 15),
          ),
          _getUnidad(widget._medida.unidad),
          const SizedBox(width: 5),
          Text(
            widget._ingrediente.nombre,
            style: const TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }

  Text _getUnidad(String unidad) {
    if (unidad == "") {
      return Text("");
    }
    return Text(
      " " + unidad + " de",
      style: const TextStyle(fontSize: 15),
    );
  }
}
