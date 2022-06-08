import 'package:flutter/material.dart';
import 'package:letscookit/config/palette.dart';
import 'package:letscookit/utilities/funciones_comprobacion.dart';
import 'package:letscookit/utilities/ingrediente.dart';
import 'package:letscookit/utilities/libro_recetas.dart';
import 'package:letscookit/utilities/lista_mis_recetas.dart';
import 'package:letscookit/utilities/lista_receta.dart';
import 'package:letscookit/utilities/medida.dart';
import 'package:letscookit/widgets/ingrediente_input.dart';
import 'package:letscookit/widgets/recipe_image.dart';
import '../utilities/paso.dart';
import '../widgets/pasos_text_fields.dart';

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

  static List<Paso> pasosList = [];

  List<Ingrediente> ingredientes = [Ingrediente("")];
  List<Medida> medidas = [Medida(0, "")];

  int id = 0;
  String nombre = '';
  String imagen = '';
  int numPersonas = 1;
  int tiempo = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
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
                _imagenReceta.text,
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
                          onSaved: (value) {
                            if (value != null) imagen = value;
                            setState(() {});
                          },
                        ),
                      ),
                      actions: [
                        ElevatedButton(
                            onPressed: (() {
                              _imagenReceta.clear();
                              setState(() {});
                              Navigator.pop(context);
                            }),
                            child: const Text("Eliminar Imagen")),
                        ElevatedButton(
                            onPressed: (() {
                              if (_formImg.currentState!.validate()) {
                                _formImg.currentState!.save();

                                setState(() {});
                                Navigator.pop(context);
                              }
                            }),
                            child: const Text("Confirmar")),
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
                  } else if (!nombreValido(value, LibroRecetas().misRecetas)) {
                    return 'Por favor, introduzca otro nombre, ya existe una receta con este nombre';
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
                  'Añadir Ingredientes',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
              ),

              ..._getIngredientes(),

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
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      libro.crearNuevaReceta(
                          widget._lista,
                          nombre,
                          imagen,
                          numPersonas,
                          tiempo,
                          pasosList,
                          ingredientes,
                          medidas);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Receta Añadida.')),
                      );
                      _clearInputs();
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
    _imagenReceta.clear();
    _nombreReceta.clear();
    _numeroPersonas.clear();
    _tiempoReceta.clear();
    pasosList = [];
    ingredientes.clear();
    ingredientes = [Ingrediente('')];
    setState(() {});
  }

  Widget _getImagen(String linkImg, Function()? onTap) {
    RecipeImage imagen = RecipeImage(linkImg);

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
        Row(
          children: [
            Expanded(child: PasosTextFields(i, pasosList)),
            const SizedBox(
              width: 16,
            ),
            _addRemoveButton(i == pasosList.length - 1, i, true),
          ],
        ),
      );
    }
    return pasosTextFields;
  }

  List<Widget> _getIngredientes() {
    List<Widget> ingredientesFields = [];
    for (int i = 0; i < ingredientes.length; i++) {
      ingredientesFields.add(
        Row(
          children: [
            Expanded(child: IngredienteInput(i, ingredientes, medidas)),
            const SizedBox(
              width: 16,
            ),
            _addRemoveButton(i == ingredientes.length - 1, i, false),
          ],
        ),
      );
    }
    return ingredientesFields;
  }

  ///Añade el boton de añadir y eliminat
  Widget _addRemoveButton(bool add, int index, bool pasos) {
    return InkWell(
      onTap: () {
        if (add) {
          if (pasos) {
            //pasosList.add('');
          } else {
            ingredientes.add(Ingrediente(""));
            medidas.add(Medida(0, ""));
          }
        } else {
          if (pasos) {
            pasosList.removeAt(index);
          } else {
            ingredientes.removeAt(index);
            medidas.removeAt(index);
          }
        }
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
