import 'package:flutter/material.dart';
import 'package:letscookit/config/palette.dart';
import 'package:letscookit/utilities/libro_recetas.dart';
import '../widgets/pasos_text_fields.dart';

//import 'dynamic_fields.dart';

class Receipt extends StatefulWidget {
  Receipt({Key? key}) : super(key: key);

  @override
  State<Receipt> createState() => _ReceiptState();
}

class _ReceiptState extends State<Receipt> {
  final _formKey = GlobalKey<FormState>();

  List<TextEditingController> pasos = [TextEditingController()];

  TextEditingController _nombreReceta = TextEditingController();
  TextEditingController _numeroPersonas = TextEditingController();
  TextEditingController _tiempoReceta = TextEditingController();
  TextEditingController _pasoController = TextEditingController();

  static List<String> pasosList = [""];

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

              const Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Text(
                  'Añadir Pasos',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
              ),
              ..._getPasos(), // Inserta todos los widgets de la lista en el form

              const SizedBox(height: 48.0),

              //Spacer(), //PARA QUE EL BOTON ESTÉ DEBAJO DEL TODO
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

  /// get firends text-fields
  List<Widget> _getPasos() {
    List<Widget> pasosTextFields = [];
    for (int i = 0; i < pasosList.length; i++) {
      pasosTextFields.add(
        // Padding(
        // padding: const EdgeInsets.symmetric(vertical: 16.0),
        // child:
        Row(
          children: [
            Expanded(child: PasosTextFields(i, pasosList)),
            SizedBox(
              width: 16,
            ),
            // we need add button at last friends row
            _addRemoveButton(i == pasosList.length - 1, i),
          ],
        ),
        // )
      );
    }
    return pasosTextFields;
  }

  ///Añade el boton de añadir y eliminat
  Widget _addRemoveButton(bool add, int index) {
    return InkWell(
      onTap: () {
        if (add) {
          // add new text-fields at the top of all friends textfields
          pasosList.insert(0, '');
        } else
          pasosList.removeAt(index);
        setState(() {});
      },
      child: Container(
        width: 30,
        height: 30,
        child: Icon(
          (add) ? Icons.add : Icons.remove,
          color: (add) ? Palette.mainGreen : Colors.red[300],
        ),
      ),
    );
  }
}
