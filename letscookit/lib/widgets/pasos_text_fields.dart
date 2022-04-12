import 'package:flutter/material.dart';
import 'package:letscookit/pages/receipt.dart';

class PasosTextFields extends StatefulWidget {
  final int index;
  PasosTextFields(this.index);

  @override
  _PasosTextFields createState() => _PasosTextFields();
}

class _PasosTextFields extends State<PasosTextFields> {
  TextEditingController _pasoController = new TextEditingController();

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
      _pasoController.text = _ReceiptState.textPasos[widget.index] ?? '';
    });

    return TextFormField(
      controller: _pasoController,
      decoration: const InputDecoration(
        icon: Icon(Icons.person_rounded),
        hintText: 'Introduce el paso: ',
        labelText: 'Descripcion Paso',
      ),
      onChanged: (value) => _ReceiptState.textPasos[widget.index] = value,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, introduzca una descripción del paso o elimínelo';
        }
        return null;
      },
    );
  }
}
