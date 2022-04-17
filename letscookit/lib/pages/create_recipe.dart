import 'dart:html';

import 'package:flutter/material.dart';
import 'package:letscookit/config/palette.dart';
import 'package:letscookit/utilities/libro_recetas.dart';
import 'package:letscookit/utilities/lista.dart';
import 'package:letscookit/utilities/lista_receta.dart';
import 'package:letscookit/utilities/receta.dart';
import 'package:letscookit/widgets/recipe_image.dart';
import '../widgets/pasos_text_fields.dart';

//import 'dynamic_fields.dart';

class CreateRecipe extends StatefulWidget {
  ListaReceta? _lista;
  CreateRecipe({Key? key})
      : _lista = null,
        super(key: key);
  CreateRecipe.conLista(this._lista, {Key? key}) : super(key: key);

  @override
  State<CreateRecipe> createState() => _CreateRecipeState();
}

class _CreateRecipeState extends State<CreateRecipe> {
  final _formKey = GlobalKey<FormState>();
  final _formImg = GlobalKey<FormState>();

  List<TextEditingController> pasos = [TextEditingController()];

  LibroRecetas libro = LibroRecetas();

  TextEditingController _imagenReceta = TextEditingController();
  TextEditingController _nombreReceta = TextEditingController();
  TextEditingController _numeroPersonas = TextEditingController();
  TextEditingController _tiempoReceta = TextEditingController();
  TextEditingController _pasoController = TextEditingController();

  static List<String> pasosList = [""];

  String nombre = '';
  String imagen = '';
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
              // const SizedBox(height: 24.0),

              _getImagen(
                imagen,
                (() {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      content: Form(
                        key: _formImg,
                        child: TextFormField(
                          controller: _imagenReceta,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.camera_rounded),
                            hintText: 'Introduce el enlace de la imagen',
                            labelText: 'Imagen',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, introduzca una imagen';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            if (value != null) imagen = value;
                            setState(() {});
                          },
                        ),
                      ),
                      actions: [
                        ElevatedButton(
                            onPressed: (() {
                              if (_formImg.currentState!.validate()) {
                                _formImg.currentState!.save();

                                setState(() {});
                                Navigator.pop(context);
                              }
                            }),
                            child: Text("Confirmar"))
                      ],
                    ),
                  );
                }),
              ),

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
                onSaved: (value) {
                  if (value != null) nombre = value;
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
                onSaved: (value) {
                  if (value != null) numPersonas = int.parse(value);
                },
              ),
              TextFormField(
                controller: _tiempoReceta,
                keyboardType: TextInputType.number,
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
                onSaved: (value) {
                  if (value != null) tiempo = int.parse(value);
                },
                onEditingComplete: () {
                  setState(() {});
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

              Center(
                child: ElevatedButton(
                  // style: ElevatedButton.styleFrom(
                  // primary: Color.fromARGB(255, 52, 160, 164)),
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      libro.crearNuevaReceta(widget._lista, '', nombre,
                          numPersonas, tiempo, pasosList);

                      _clearInputs();
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

  void _clearInputs() {
    _nombreReceta.clear();
    _numeroPersonas.clear();
    _tiempoReceta.clear();
    pasosList = [''];
    setState(() {});
  }

  Widget _getImagen(String linkImg, Function()? onTap) {
    RecipeImage imagen = RecipeImage('assets/noimageavailable.png');
    if (linkImg != '') imagen = RecipeImage(linkImg);

    return GestureDetector(
      onTap: onTap,
      child: imagen,
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
          // add new text-fields at the bottom of all friends textfields
          pasosList.add('');
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
