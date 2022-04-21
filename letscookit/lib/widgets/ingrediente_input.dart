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
        SizedBox(
          width: 200,
          child: TextFormField(
            controller: _ingredienteController,
            decoration: const InputDecoration(
              hintText: "Nombre",
              labelText: 'Ingrediente',
            ),
            onSaved: (value) => _ingredienteController.clear(),
            onTap: (() {
              showDialog(
                context: context,
                builder: (_) => SimpleDialog(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: SearchBar(
                        controller: _searchController,
                        hint: "Ingrediente",
                        suggestions: ListaIngredientes()
                            .lista
                            .map((e) => SearchFieldListItem<Ingrediente>(
                                e.nombre,
                                item: e))
                            .toList(),
                        onSuggestionTap: (value) {
                          setState(() {
                            widget._ingredientes[widget._index] = value.item;
                            _ingredienteController.text =
                                _searchController.text;
                            Navigator.pop(context);
                            setState(() {});
                          });
                        },
                        onSubmit: (value) {
                          int indice =
                              ListaIngredientes().buscaIngrediente(value);
                          if (indice == -1) {
                            ListaIngredientes().add(Ingrediente(value));
                            indice = ListaIngredientes().length() - 1;
                          }
                          widget._ingredientes[widget._index] =
                              ListaIngredientes().get(indice);
                          _ingredienteController.text = _searchController.text;
                          _searchController.clear();
                          Navigator.pop(context);
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
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
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: TextFormField(
            controller: _unidadIngrediente,
            decoration: const InputDecoration(
              hintText: "Texto",
              labelText: 'Unidad',
            ),
            onChanged: (value) => widget._medidas[widget._index].unidad = value,
            onSaved: (value) => _unidadIngrediente.clear(),
          ),
        ),
      ],
    );
  }
}
