import 'package:flutter/material.dart';
import 'package:letscookit/config/palette.dart';
import 'package:letscookit/utilities/libro_recetas.dart';
import 'package:letscookit/utilities/lista_receta.dart';
import 'package:letscookit/utilities/funciones_comprobacion.dart';

class CreateList extends StatefulWidget {
  const CreateList({Key? key}) : super(key: key);

  @override
  State<CreateList> createState() => _CreateListState();
}

class _CreateListState extends State<CreateList> {
  TextEditingController _nombreLista = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crear Lista"),
      ),
      body: Center(
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 60.0,
              ),
              const Text(
                'Ponle un título a tu lista',
                style: TextStyle(
                  fontSize: 30.0,
                ),
              ),
              const SizedBox(
                height: 60.0,
              ),
              SizedBox(
                height: 30.0,
                width: 300.0,
                child: TextFormField(
                  controller: _nombreLista,
                  decoration: InputDecoration(
                      hintText: 'Lista nº ${LibroRecetas().length() + 1}',
                      hintStyle: TextStyle(
                        color: Colors.grey[700],
                      )),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancelar'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey[700],
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 5.0),
                        textStyle: TextStyle(color: Colors.grey[200]),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        String nombre =
                            "Lista nº ${LibroRecetas().length() + 1}";

                        if (_nombreLista.value.text != "" &&
                            nombreValido(
                                _nombreLista.value.text, LibroRecetas())) {
                          nombre = _nombreLista.value.text;
                        }

                        LibroRecetas().add(ListaReceta(nombre));
                        _nombreLista.clear();
                        setState(() {});
                        //Una vez crea la lista, se dirige a la página de la misma
                        Navigator.pop(context);
                      },
                      child: const Text('Crear'),
                      style: ElevatedButton.styleFrom(
                        primary: Palette.mainBlue,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 5.0),
                        textStyle: TextStyle(color: Colors.black),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
