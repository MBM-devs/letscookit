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
  String nombre;
  RecipeList(this.nombre, {Key? key}) : super(key: key);
  @override
  State<RecipeList> createState() => _RecipeListState(nombre);
}

class _RecipeListState extends State<RecipeList> {
  String nombre = "Mi Lista nº1";
  _RecipeListState(nombre);
  ListaReceta listaReceta = ListaReceta("Mi Lista nº1");

  final List<String> _settingsMenu = ["Cambiar Nombre", "Eliminar Lista"];

  TextEditingController _nombreLista = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(listaReceta.nombre),
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
                itemCount: listaReceta.length(),
                itemBuilder: (BuildContext context, int index){
                  return Card(
                    child: ListTile(
                      title: Text(listaReceta.get(index).nombre),
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecipeView(listaReceta.get(index)), //Lleva a la página de la receta
                          ),
                        );
                      },
                      leading: CircleAvatar(

                      ),
                    ),
                  );
                }
              ),
              const SizedBox(
                height: 20.0,
                width: 1.0,
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text("Añadir Receta"),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateRecipe(),
                      )
                  );
                },
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
            builder: (context) => _buildChangePopupDialog(context)
        );
        break;
      case "Eliminar Lista":
        showDialog(
            context: context,
            builder: (context) => _buildDeletePopupDialog(context)
        );
        break;
    }
  }
  Widget _buildChangePopupDialog(BuildContext context){
    String nuevoNombre = "";
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
                hintText: '$nombre',
                hintStyle: TextStyle(
                  color: Colors.grey[700],
                  fontStyle: FontStyle.italic,
                )
              ),
              onChanged: (value) {
                nuevoNombre = value;
              },
              validator: (value){
                if(value == null || value.isEmpty){
                  nuevoNombre = "AS";
                  return "Introduzca un nombre para la lista por favor.";
                }
                return null;
              },
            ),
          ),
          const SizedBox(
            height: 30.0,
            width: 1.0,
          ),
          ElevatedButton(
              onPressed: (){
                print("Nuevonombre:${nuevoNombre}diooos");
                listaReceta.nombre=nuevoNombre;
                _clearInput();
                Navigator.pop(context);
                /*Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RecipeList(nombre),
                    ),
                );*/
                //_clearInput();
              },
              child: const Text("Cambiar")
          ),
        ],
      ),
    );
  }

  Widget _buildDeletePopupDialog(BuildContext context){
    return AlertDialog(
      title: const Text("¿Está seguro de que desea eliminar ésta lista?"),
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
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Lista Eliminada')),
                  );
                  //Una vez crea la lista, se dirige a la página de la misma
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecipeList(nombre),
                      )
                  );
                },
                child: const Text('Eliminar'), //Podriamos poner que si el campo esta vacío, ponga 'Saltar' en vez de 'Crear'
                style: ElevatedButton.styleFrom(
                  primary: Colors.red[400],
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 5.0),
                  textStyle: TextStyle(color: Colors.black),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
  void _clearInput() {
    _nombreLista.clear();
    setState(() {});
  }
}
