import 'package:flutter/material.dart';
import 'package:letscookit/utilities/receta.dart';

class RecipeImage extends StatefulWidget {
  String _imagen;

  RecipeImage(this._imagen);
  @override
  _RecipeImageState createState() => _RecipeImageState(_imagen);
}

class _RecipeImageState extends State<RecipeImage> {
  String _imagen;

  _RecipeImageState(this._imagen);

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
      child: Image.network(_imagen, fit: BoxFit.cover),
    );
  }
}
