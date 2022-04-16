import 'package:flutter/material.dart';
import 'package:letscookit/utilities/receta.dart';

class RecipeView extends StatefulWidget {
  Receta _receta;
  RecipeView(this._receta, {Key? key}) : super(key: key);

  @override
  State<RecipeView> createState() => _RecipeViewState(_receta);
}

class _RecipeViewState extends State<RecipeView> {
  Receta _receta;
  _RecipeViewState(this._receta);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
