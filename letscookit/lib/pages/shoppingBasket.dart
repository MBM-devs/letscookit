import 'package:flutter/material.dart';
import '../widgets/searchIngrediente.dart';

class shoppingBasket extends StatefulWidget {
  shoppingBasket({Key? key}) : super(key: key);

  @override
  State<shoppingBasket> createState() => _shoppingBasketState();
}

class _shoppingBasketState extends State<shoppingBasket> {
  @override
  Widget build(BuildContext context) {
    return SearchIngrediente();
  }
}
