import 'package:flutter/material.dart';
import 'package:letscookit/config/palette.dart';
import 'package:letscookit/pages/recipe_view.dart';
import 'package:letscookit/utilities/libro_recetas.dart';
import 'package:letscookit/utilities/lista.dart';
import 'package:letscookit/utilities/lista_receta.dart';
import 'package:letscookit/utilities/receta.dart';
import '../widgets/pasos_text_fields.dart';
import 'create_recipe.dart';

class RecipeList extends StatefulWidget {
  ListaReceta listaRecetas;
  RecipeList(this.listaRecetas, {Key? key}) : super(key: key);
  @override
  State<RecipeList> createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  List<String> _settingsMenu = ["Cambiar Nombre", "Eliminar Lista"];
  TextEditingController _nombreLista = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.listaRecetas.nombre),
        actions: [
          PopupMenuButton(
            onSelected: handleClick,
            icon: const Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) {
              return _settingsMenu.map((String choice) {
                return PopupMenuItem(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Center(
        child: Form(
          child: Column(
            children: [
              ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: widget.listaRecetas.length(),
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        title: Text(widget.listaRecetas.get(index).nombre),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RecipeView(widget
                                  .listaRecetas
                                  .get(index)), //Lleva a la página de la receta
                            ),
                          );
                        },
                        leading: CircleAvatar(),
                      ),
                    );
                  }),
              const SizedBox(
                height: 20.0,
                width: 1.0,
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text("Añadir Receta"),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  void handleClick(String value) {
    switch (value) {
      case "Cambiar Nombre":
        showDialog(
            context: context,
            builder: (context) => _buildChangePopupDialog(context));
        break;
      case "Eliminar Lista":
        showDialog(
            context: context,
            builder: (context) => _buildDeletePopupDialog(context));
        break;
    }
  }

  Widget _buildChangePopupDialog(BuildContext context) {
    return AlertDialog(
      title: const Text("Introduce el nuevo nombre: "),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10.0,
            width: 1.0,
          ),
          SizedBox(
            height: 30.0,
            width: 300.0,
            child: TextFormField(
              controller: _nombreLista,
              decoration: InputDecoration(
                  hintText: widget.listaRecetas.nombre,
                  hintStyle: TextStyle(
                    color: Colors.grey[700],
                  )),
            ),
          ),
          const SizedBox(
            height: 30.0,
            width: 1.0,
          ),
          ElevatedButton(
              onPressed: () {
                if (_nombreLista.value.text != "" &&
                    LibroRecetas().nombreValido(_nombreLista.value.text)) {
                  widget.listaRecetas.nombre = _nombreLista.value.text;
                }
                _nombreLista.clear();
                setState(() {});
                Navigator.pop(context);
              },
              child: const Text("Cambiar")),
        ],
      ),
    );
  }

  Widget _buildDeletePopupDialog(BuildContext context) {
    return AlertDialog(
      title: const Text("¿Está seguro de eliminar esta lista?"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey[700],
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 5.0),
                  textStyle: TextStyle(color: Colors.grey[200]),
                ),
                child: const Text('Cancelar'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red[400],
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 5.0),
                  textStyle: const TextStyle(color: Colors.black),
                ),
                child: const Text(
                    'Eliminar'), //Podriamos poner que si el campo esta vacío, ponga 'Saltar' en vez de 'Crear'
                onPressed: () {
                  LibroRecetas().eliminarLista(widget.listaRecetas);
                  setState(() {});
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
