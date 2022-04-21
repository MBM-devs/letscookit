import 'package:flutter/material.dart';
import 'package:letscookit/utilities/libro_recetas.dart';
import 'create_list.dart';

class Bookmark extends StatefulWidget {
  Bookmark({Key? key}) : super(key: key);

  @override
  State<Bookmark> createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: LibroRecetas().length(),
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: ListTile(
                  title: Text(LibroRecetas().get(index).nombre),
                  onTap: () {
                    Navigator.pushNamed(context, '/lista/' + index.toString())
                        .then((_) => setState(() {}));
                  },
                ),
              );
            }),
        const SizedBox(
          height: 10.0,
          width: 1.0,
        ),
        ElevatedButton(
          child: const Text("Crear Nueva Lista"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CreateList(),
              ),
            ).then((_) => setState(() {}));
          },
        ),
      ],
    );
  }
}
