import 'package:flutter/material.dart';
import 'package:letscookit/utilities/receta.dart';

class RecipeImage extends StatefulWidget {
  String _imagen;

  RecipeImage(this._imagen);
  @override
  // String get imagen => _imagen;
  _RecipeImageState createState() => _RecipeImageState();
}

class _RecipeImageState extends State<RecipeImage> {
  _RecipeImageState();

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      height: 320,
      margin: EdgeInsets.only(top: 30, left: 30, right: 30),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Image.network(widget._imagen, fit: BoxFit.cover),
    );
  }
}
