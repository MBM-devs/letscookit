import 'package:flutter/material.dart';
import 'package:letscookit/utilities/ingrediente.dart';
import 'package:letscookit/utilities/lista_ingredientes.dart';
import 'package:letscookit/utilities/medida.dart';
import 'package:letscookit/widgets/search_bar.dart';
import 'package:searchfield/searchfield.dart';

class IngredienteInput extends StatefulWidget {
  int _index;

  List<Ingrediente> _ingredientes;
  List<Medida> _medidas;

  IngredienteInput(this._index, this._ingredientes, this._medidas, {Key? key})
      : super(key: key);

  @override
  State<IngredienteInput> createState() => _IngredienteInputState();
}

class _IngredienteInputState extends State<IngredienteInput> {
  TextEditingController _cantidadIngrediente = TextEditingController();
  TextEditingController _unidadIngrediente = TextEditingController();
  TextEditingController _searchController = TextEditingController();
  TextEditingController _ingredienteController = TextEditingController();
  Ingrediente? _selecionado;

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        //Columna ingrediente y cant y unid
        Column(
          children: [
            //Ingrediente
            Row(
              children: [
                SizedBox(
                  width: 300,
                  child:  TextFormField(
                      controller: _ingredienteController,
                      decoration: const InputDecoration(
                        hintText: "Nombre",
                        labelText: 'Ingrediente',
                      ),
                      onChanged: (value) => {
                        widget._ingredientes[widget._index].nombre = value,
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, introduzca un nombre de ingrediente o elimínelo';
                        }
                        return null;
                      }
                  ),
                ),
              ],
            ),
            //Cantidad y unidad
            Row(
              children: [
                //SizedBox(width: 20,),
                Column(
                  children: [
                    SizedBox(
                      width: 100,
                      child: TextFormField(
                        controller: _cantidadIngrediente,
                        decoration: const InputDecoration(
                          hintText: "Numero",
                          labelText: 'Cantidad',
                        ),
                        onChanged: (value) {
                          widget._medidas[widget._index].cantidad = int.parse(value);
                        },
                        onSaved: (value) => _cantidadIngrediente.clear(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, introduzca una cantidad';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 50),
                Column(
                  children: [
                    SizedBox(
                      width: 150,
                      child: TextFormField(
                        controller: _unidadIngrediente,
                        decoration: const InputDecoration(
                          hintText: "Texto",
                          labelText: 'Unidad',
                        ),
                        onChanged: (value) => widget._medidas[widget._index].unidad = value,
                        onSaved: (value) => _unidadIngrediente.clear(),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}