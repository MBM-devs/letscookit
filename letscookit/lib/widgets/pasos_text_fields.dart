import 'package:flutter/material.dart';
import 'package:letscookit/config/palette.dart';
import 'package:letscookit/pages/create_recipe.dart';

class PasosTextFields extends StatefulWidget {
  final int index;
  List<String> pasosList;
  PasosTextFields(this.index, this.pasosList);

  @override
  _PasosTextFields createState() => _PasosTextFields();
}

class _PasosTextFields extends State<PasosTextFields> {
  TextEditingController _pasoController = TextEditingController();

  _PasosTextFields();
  @override
  void initState() {
    super.initState();
    _pasoController = TextEditingController();
  }

  @override
  void dispose() {
    _pasoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _pasoController.text = widget.pasosList[widget.index];
    });
    return TextFormField(
      controller: _pasoController,
      decoration: InputDecoration(
        icon: Container(
          width: 20,
          height: 30,
          child: Center(
            child: Text(
              "${widget.index + 1}",
              style: const TextStyle(color: Colors.grey, fontSize: 18),
            ),
          ),
          // decoration: BoxDecoration(
          //   border: Border.all(
          //     width: 2,
          //     color: Colors.grey,
          //   ),
          //   borderRadius: BorderRadius.circular(20),
          // ),
        ),
        hintText: 'Introduce el paso ',
        labelText: 'Descripcion Paso',
      ),
      onChanged: (value) => widget.pasosList[widget.index] = value,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, introduzca una descripción del paso o elimínelo';
        }
        return null;
      },
    );
  }
}
