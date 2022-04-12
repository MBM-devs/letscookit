import 'package:flutter/material.dart';
import 'package:letscookit/utilities/libro_recetas.dart';
// import '../widgets/pasos_text_fields.dart';

//import 'dynamic_fields.dart';

class Receipt extends StatefulWidget {
  Receipt({Key? key}) : super(key: key);

  @override
  State<Receipt> createState() => _ReceiptState();
}

class _ReceiptState extends State<Receipt> {
  final _formKey = GlobalKey<FormState>();

  List<TextEditingController> pasos = [TextEditingController()];
  static List<String> pasosStringList = [];

  TextEditingController _nombreReceta = TextEditingController();
  TextEditingController _numeroPersonas = TextEditingController();
  TextEditingController _tiempoReceta = TextEditingController();
  TextEditingController _pasoController = TextEditingController();

  String nombre = '';
  int numPersonas = 1;
  int tiempo = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 24.0),
              TextFormField(
                controller: _nombreReceta,
                decoration: const InputDecoration(
                  icon: Icon(Icons.restaurant_rounded),
                  hintText: 'Introduce el nombre de la Receta',
                  labelText: 'Nombre',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduzca un nombre';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _numeroPersonas,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person_rounded),
                  hintText: 'Introduce el numero de personas de la receta.',
                  labelText: 'Numero de personas',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduzca un número de personas';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _tiempoReceta,
                decoration: const InputDecoration(
                  icon: Icon(Icons.access_time_rounded),
                  hintText: 'Introduce la duración de la receta.',
                  labelText: 'Duracion',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduzca el tiempo aproximado de la receta';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _pasoController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.access_time_rounded),
                  hintText: 'Introduce la descripcion del paso.',
                  labelText: 'Descripcion paso',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduzca la descripcion del paso o elimínelo';
                  }
                  return null;
                },
              ),

              // TextFormField(
              //   controller: _pasos,
              //   decoration: const InputDecoration(
              //     icon: Icon(Icons.text_fields),
              //     hintText: 'Introduce los pasos de la receta',
              //     labelText: 'Pasos',
              //   ),
              // ),
              const SizedBox(height: 48.0),

              // Spacer(), PARA QUE EL BOTON ESTÉ DEBAJO DEL TODO
              Center(
                child: ElevatedButton(
                  // style: ElevatedButton.styleFrom(
                  // primary: Color.fromARGB(255, 52, 160, 164)),
                  onPressed: () {
                    nombre = _nombreReceta.text;
                    numPersonas = int.parse(_numeroPersonas.text);
                    tiempo = int.parse(_tiempoReceta.text);

                    if (nombre != '' && numPersonas > 0 && tiempo > 0) {
                      LibroRecetas()
                          .crearNuevaReceta(null, nombre, numPersonas, tiempo);
                    }

                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                    }
                  },
                  child: const Text('Crear'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _getPasos() {
    List<Widget> friendsTextFieldsList = [];
    for (int i = 0; i < pasosStringList.length; i++) {
      friendsTextFieldsList.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            Expanded(child: PasosTextFields(i)),
            SizedBox(
              width: 16,
            ),
            // we need add button at last friends row only
            _addRemoveButton(i == pasosStringList.length - 1, i),
          ],
        ),
      ));
    }
    return friendsTextFieldsList;
  }

  Widget _addRemoveButton(bool add, int index) {
    return InkWell(
      onTap: () {
        if (add) {
          // add new text-fields at the top of all friends textfields
          pasosStringList.insert(0, '');
        } else
          pasosStringList.removeAt(index);
        setState(() {});
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: (add) ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          (add) ? Icons.add : Icons.remove,
          color: Colors.white,
        ),
      ),
    );
  }
}

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
      _pasoController.text = _ReceiptState.pasosStringList[widget.index] ?? '';
    });

    return TextFormField(
      controller: _pasoController,
      decoration: const InputDecoration(
        icon: Icon(Icons.person_rounded),
        hintText: 'Introduce el paso: ',
        labelText: 'Descripcion Paso',
      ),
      onChanged: (value) => _ReceiptState.pasosStringList[widget.index] = value,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, introduzca una descripción del paso o elimínelo';
        }
        return null;
      },
    );
  }
}
