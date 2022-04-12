import 'package:flutter/material.dart';
import 'package:letscookit/utilities/libro_recetas.dart';

class Receipt extends StatefulWidget {
  Receipt({Key? key}) : super(key: key);

  @override
  State<Receipt> createState() => _ReceiptState();
}

class _ReceiptState extends State<Receipt> {
  final _formKey = GlobalKey<FormState>();

  final nombreReceta = TextEditingController();
  final numeroPersonas = TextEditingController();
  final tiempoReceta = TextEditingController();

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
                controller: nombreReceta,
                decoration: const InputDecoration(
                  icon: Icon(Icons.restaurant_rounded),
                  hintText: 'Introduce el nombre de la Receta',
                  labelText: 'Nombre',
                ),
              ),
              TextFormField(
                controller: numeroPersonas,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person_rounded),
                  hintText: 'Introduce el numero de personas de la receta.',
                  labelText: 'Numero de personas',
                ),
              ),
              TextFormField(
                controller: tiempoReceta,
                decoration: const InputDecoration(
                  icon: Icon(Icons.access_time_rounded),
                  hintText: 'Introduce la duración de la receta.',
                  labelText: 'Duracion',
                ),
              ),
              const SizedBox(height: 48.0),

              // Spacer(), PARA QUE EL BOTON ESTÉ DEBAJO DEL TODO
              Center(
                child: ElevatedButton(
                  // style: ElevatedButton.styleFrom(
                  // primary: Color.fromARGB(255, 52, 160, 164)),
                  onPressed: () {
                    // nombre = nombreReceta.text;
                    // numPersonas = int.parse(numeroPersonas.text);
                    // tiempo = int.parse(tiempoReceta.text);

                    // if (nombre != '' && numPersonas > 0) {
                    //   LibroRecetas()
                    //       .crearNuevaReceta(null, nombre, numPersonas, tiempo);
                    // }

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
}
