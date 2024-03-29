import 'package:flutter/material.dart';
import 'package:letscookit/pages/recipe_view.dart';
import 'package:letscookit/utilities/libro_recetas.dart';
import 'package:letscookit/utilities/lista_receta.dart';
import 'package:letscookit/utilities/receta.dart';
import 'package:searchfield/searchfield.dart';
import '../widgets/search_bar.dart';
import 'package:letscookit/utilities/funciones_comprobacion.dart';

class RecipeList extends StatefulWidget {
  ListaReceta _listaRecetas;
  RecipeList(this._listaRecetas, {Key? key}) : super(key: key);
  @override
  State<RecipeList> createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  List<String> _settingsMenu = ["Cambiar Nombre", "Eliminar Lista"];
  TextEditingController _nombreLista = TextEditingController();
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._listaRecetas.nombre),
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
                  itemCount: widget._listaRecetas.length(),
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        title: Text(widget._listaRecetas.get(index).nombre),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  RecipeView(widget._listaRecetas.get(index)),
                            ),
                          ).then((_) => setState(() {}));
                        },
                        leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                widget._listaRecetas.get(index).imagen)),
                      ),
                    );
                  }),
              const SizedBox(
                height: 20.0,
                width: 1.0,
              ),
              _buttonAddReceta(),
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
                  hintText: widget._listaRecetas.nombre,
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
                    nombreValido(_nombreLista.value.text, LibroRecetas())) {
                  widget._listaRecetas.nombre = _nombreLista.value.text;
                }
                _nombreLista.clear();
                Navigator.pop(context);
                setState(() {});
              },
              child: const Text("Cambiar")),
        ],
      ),
    );
  }

  Widget _buttonAddReceta() {
    ElevatedButton button = ElevatedButton.icon(
      icon: const Icon(Icons.add),
      label: const Text("Añadir Receta"),
      onPressed: () {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
              content: Container(
            height: 300,
            padding: EdgeInsets.all(10.0),
            child: SearchBar(
              controller: _searchController,
              hint: "Buscar receta...",
              suggestions: LibroRecetas()
                  .misRecetas
                  .lista
                  .map((e) => SearchFieldListItem<Receta>(e.nombre, item: e))
                  .toList(),
              onSuggestionTap: (value) {
                setState(() {
                  widget._listaRecetas.add(value.item);
                });
                _searchController.clear();
              },
            ),
          )),
        );
      },
    );
    if (widget._listaRecetas == LibroRecetas().misRecetas) {
      button = ElevatedButton.icon(
        icon: const Icon(Icons.add),
        label: const Text("Crear Receta"),
        onPressed: () {
          Navigator.pushNamed(context, '/crear_receta')
              .then((_) => setState(() {}));
        },
      );
    }
    return button;
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
                  setState(() {});
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red[400],
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 5.0),
                  textStyle: const TextStyle(color: Colors.black),
                ),
                child: const Text('Eliminar'),
                onPressed: () {
                  LibroRecetas().eliminarLista(widget._listaRecetas);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  setState(() {});
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
