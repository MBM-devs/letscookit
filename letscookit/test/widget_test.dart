// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:letscookit/main.dart';
import 'package:letscookit/pages/bookmark.dart';
import 'package:letscookit/pages/shopping_basket.dart';
import 'package:letscookit/pages/create_recipe.dart';
import 'package:letscookit/utilities/ingrediente.dart';
import 'package:letscookit/utilities/lista_compra.dart';
import 'package:letscookit/utilities/lista_ingredientes.dart';
import 'package:letscookit/widgets/recipe_image.dart';
import 'package:searchfield/searchfield.dart';

void main() {
  testWidgets('Se crea un ingrediente desde la lista de la compra y se añade el ingrediente tanto a ésta como a la lista de ingredientes.', (WidgetTester tester) async {
    // No existe ningun ingrediente con el nombre que vamos a añadir
    expect(ListaIngredientes().existeIngrediente('Aguacate'), false);
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ShoppingBasket(),
      ),
    ));

    var search_bar = find.byType(TextField);

    expect(search_bar, findsOneWidget);

    await tester.enterText(search_bar, 'Aguacate');
    await tester.pumpAndSettle();
    expect(find.text('Aguacate'), findsOneWidget);

    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();

    Ingrediente added = ListaCompra().get(ListaCompra().length()-1);
   
    //Se ha añadido Aguacate a la lista de la compra
    expect(added.nombre, 'Aguacate');
    //El objeto añadido a la lista de la compra es el mismo que se ha añadido a la Lista de ingrendientes
    expect(added,ListaIngredientes().get(ListaIngredientes().length()-1));
   
  });

  testWidgets('Se borran los ingredientes marcados de la lista de la compra', (WidgetTester tester) async {
    expect(ListaCompra().hayComprados(), false);
    ListaCompra().add(Ingrediente("Rábanos"));
    ListaCompra().add(Ingrediente("Plátanos"));
    int lenghtAntesComprar = ListaCompra().length();
    expect(lenghtAntesComprar > 0, true);
    
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ShoppingBasket(),
      ),
    ));

    expect(find.text("Plátanos"), findsOneWidget);

    await tester.tap(find.text("Plátanos"));

    expect(ListaCompra().hayComprados(), true);
    expect(find.text("Borrar comprados"), findsOneWidget);

    await tester.tap(find.text("Borrar comprados"));
    await tester.pumpAndSettle();

    expect(find.byType(ElevatedButton), findsNWidgets(3));

    await tester.tap(find.text("Si"));
    await tester.pumpAndSettle();

    expect(ListaCompra().hayComprados(), false);
    expect(ListaCompra().length() == (lenghtAntesComprar - 1), true);

  }); 

  testWidgets('Se crea una lista del libro de recetas', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Bookmark(),
      ),
    ));

    var boton = find.text("Crear Nueva Lista");
    expect(boton, findsOneWidget);

    await tester.tap(boton);
    await tester.pumpAndSettle();

    var textField = find.byType(TextField);
    await tester.enterText(textField, 'Nueva Lista');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();

    expect(find.text('Nueva Lista'), findsOneWidget);

    boton = find.text("Crear");
    expect(boton, findsOneWidget);
    await tester.tap(boton);
    await tester.pumpAndSettle();

    expect(find.text('Nueva Lista'), findsOneWidget);

  }); 

  
 testWidgets('Se elimina una lista del libro de recetas', (WidgetTester tester) async {

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Bookmark(),
      ),
    ));

    expect(find.text("Nueva Lista"), findsOneWidget);
    await tester.tap(find.text("Nueva Lista"));
    await tester.pumpAndSettle();

    var menu = find.byIcon(Icons.more_vert);
    expect(menu, findsOneWidget);
    await tester.tap(menu);
    await tester.pumpAndSettle();

    var btnEliminar =  find.text("Eliminar Lista");
    expect(btnEliminar, findsOneWidget);
    await tester.tap(btnEliminar);
    


  }); 

}
