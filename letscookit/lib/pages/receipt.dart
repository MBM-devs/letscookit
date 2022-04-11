import 'package:flutter/material.dart';
import 'package:letscookit/utilities/receta.dart';

class Receipt extends StatefulWidget {
  Receipt({Key? key}) : super(key: key);

  @override
  State<Receipt> createState() => _ReceiptState();
}

class _ReceiptState extends State<Receipt> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.restaurant_rounded),
                  hintText: 'Introduce el nombre de la Receta',
                  labelText: 'Nombre',
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.person_rounded),
                  hintText: 'Introduce el numero de personas de la receta.',
                  labelText: 'Numero de personas',
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.access_time_rounded),
                  hintText: 'Introduce la duración de la receta.',
                  labelText: 'Duracion',
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 52, 160, 164)),
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
