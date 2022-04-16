import 'package:flutter/material.dart';

class RecipeView extends StatefulWidget {
  RecipeView({Key? key}) : super(key: key);

  @override
  State<RecipeView> createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Receta'),
    );
  }
}
