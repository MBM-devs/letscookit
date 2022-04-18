import 'package:flutter/material.dart';
import 'package:letscookit/config/palette.dart';
import 'package:letscookit/utilities/libro_recetas.dart';
import 'package:letscookit/utilities/lista.dart';
import 'package:letscookit/utilities/lista_receta.dart';
import '../widgets/pasos_text_fields.dart';
import 'create_recipe.dart';

class RecipeList extends StatefulWidget {
  String _nombre;
  RecipeList(this._nombre, {Key? key}) : super(key: key);

  @override
  State<RecipeList> createState() => _RecipeListState(_nombre);
}

class _RecipeListState extends State<RecipeList> {
  String nombre = "Mi Lista nº1";
  _RecipeListState(nombre);
  ListaReceta listaReceta = ListaReceta("nombre");
  List<String> _settingsMenu = ["Cambiar Nombre", "Eliminar Lista"];

  TextEditingController _nombreLista = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${nombre}"),
        actions: [
          PopupMenuButton(
            onSelected: handleClick,
            icon: Icon(Icons.more_vert),
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
                            builder: (context) => listaReceta.get(index), //Lleva a la página de la receta
                          ),
                        );
                      },
                      leading: CircleAvatar(
                        //backgroundImage: ,
                      ),
                    ),
                  );
                }
              ),
              ElevatedButton.icon(
                icon: Icon(Icons.add),
                label: Text("Añadir Receta"),
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
            builder: (context) => _buildPopupDialog(context)
        );
        break;
      case "Eliminar Lista":
        break;
    }
  }
  Widget _buildPopupDialog(BuildContext context){
    return AlertDialog(
      title: Text("Introduce el nuevo nombre "),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 30.0,
            width: 300.0,
            child: TextFormField(
              controller: _nombreLista,
              decoration: InputDecoration(
                hintText: '${nombre}',
                hintStyle: TextStyle(
                  color: Colors.grey[700],
                  fontStyle: FontStyle.italic,
                )
              ),
              onSaved: (value) {
                if(value != null){
                  nombre = value;
                }
              },
            ),
          ),
          ElevatedButton(
              onPressed: (){
                //Cambia el nombre de la pagina, llamandola otra vez?
                //_clearInput();
              },
              child: Text("Cambiar")
          ),
        ],
      ),
    );
  }
}
