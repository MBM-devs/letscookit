import 'package:flutter/material.dart';
import 'package:letscookit/config/palette.dart';
import 'package:letscookit/pages/recipe_list.dart';
import 'package:letscookit/utilities/libro_recetas.dart';
import 'package:letscookit/utilities/lista.dart';
import 'package:letscookit/utilities/lista_receta.dart';
import '../widgets/pasos_text_fields.dart';

class CreateList extends StatefulWidget {
  const CreateList({Key? key}) : super(key: key);

  @override
  State<CreateList> createState() => _CreateListState();
}

class _CreateListState extends State<CreateList> {
  LibroRecetas libro = LibroRecetas();

  TextEditingController _nombreLista = TextEditingController();
  String nombre = '';

  int numListas = 1; //libro.length();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Crear Lista"),
      ),
      //padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      body: Center(
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 60.0,
              ),
              Text(
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
                      hintText:
                          'Mi lista nº${numListas}', //Que el hint text sea el que escribirá por defecto
                      hintStyle: TextStyle(
                        color: Colors.grey[700],
                        fontStyle: FontStyle.italic,
                      )),
                  onSaved: (value) {
                    if (value != null)
                      nombre = value;
                    else {
                      nombre = 'Mi lista nº${numListas}';
                      numListas++;
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 60.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
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
                  ElevatedButton(
                    onPressed: () {
                      //libro.crearLista(nombre);
                      _clearInput();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                      //Una vez crea la lista, se dirige a la página de la misma
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecipeList(nombre),
                          )
                      );
                    },
                    child: const Text('Crear'),
                    style: ElevatedButton.styleFrom(
                      primary: Palette.mainGreen,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 5.0),
                      textStyle: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _clearInput() {
    _nombreLista.clear();
    setState(() {});
  }
}
