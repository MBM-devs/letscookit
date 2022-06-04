import 'package:flutter/material.dart';
import 'package:letscookit/bd/bd.dart';
import 'package:letscookit/utilities/libro_recetas.dart';
import 'package:letscookit/utilities/receta.dart';

class GenerarRecetas {
  void crear() {
    Receta receta = Receta("Pollo al limón", 4, 20, 'assets/PolloAlLimon.jpeg');
    receta.crearPaso(
        "Cortamos tres rodajas finas de limón y exprimimos el resto de los dos limones.");
    receta.crearPaso(
        "En un cazo, ponemos a cocer el zumo de limón con el azúcar, el caldo, una cucharada de Maizena y las tres rodajas, dejando a fuego lento hasta que espese como un jarabe.");
    receta.crearPaso(
        "Marinamos en la salsa de soja durante 30 minutos las pechugas de pollo muy limpias y cortadas por la mitad para que no sean tan gruesas.");
    receta.crearPaso(
        "Mezclamos la otra cucharada de Maizena con el huevo batido y con esa mezcla empanamos las pechugas escurridas y las freímos hasta que se doren.");
    receta.crearPaso(
        "Cortamos las pechugas en pequeñas tiras para facilitar al comensal que pueda comerlas con palillos chinos. ");
    receta.crearPaso(
        "En una fuente, ponemos las tres rodajas de limón alineadas y las cubrimos con la mitad de la salsa de limón.");
    receta.crearPaso(
        "Colocamos el pollo encima de las rodajas de limón, echamos el resto de la salsa por encima y decoramos con unas tiritas de corteza de limón y flores comestibles, llevándolo a la mesa inmediatamente para que llegue muy caliente.");
    receta.crearIngrediente(2, "", "Pechuga de pollo");
    receta.crearIngrediente(2, "", "Limon");
    receta.crearIngrediente(2, "Cucharadas", "Maizena");
    receta.crearIngrediente(1, "", "Aceite Girasol");
    receta.crearIngrediente(2, "Cucharadas", "Azucar");
    receta.crearIngrediente(100, "ml", "Caldo de pollo");
    receta.crearIngrediente(50, "ml", "Salsa de Soja");
    // receta.crearPaso("Comer");

    LibroRecetas libro = LibroRecetas();

    libro.misRecetas.add(receta);
    receta = Receta("Pollo al Curry", 4, 120, 'assets/pollo-al-curry.jpeg');
    receta.crearPaso(
        "Para preparar la receta del pollo al curry lo mejor es empezar troceando el pollo.");
    receta.crearPaso(
        "Coge las pechugas de pollo y límpialas muy bien de restos de huesecillos o grasa que puedan traer.");
    receta.crearPaso(
        "Una vez limpias, trocéalas en pedacitos de bocado. Mi consejo es que no los dejes demasiado grandes, como mucho en cuadrados de unos 3 centímetros más o menos.");
    receta.crearPaso("Salpimenta la carne.");
    receta.crearPaso(
        "A continuación pon una sartén al fuego con un poquito de aceite.");
    receta.crearPaso(
        "Con el fuego fuerte, mete los trozos de pechuga y séllalos. Ese paso lo que pretende es hacer la carne por fuera pero que se mantenga jugosa por dentro.");
    receta.crearPaso(
        "Mientras se hace el pollo, pela y trocea una cebolla. Intenta picarla muy pequeñita, tanto como para que no se note en la salsa al final de la cocción.");
    receta.crearPaso(
        "En otra sartén pon un par de cucharadas de aceite y la cebolla.");
    receta.crearPaso(
        "Deja que se cocinen a fuego bajo durante varios minutos, hasta que veas que se pone transparente.");
    receta.crearPaso(
        "Cuando veas que los trozos de pollo están dorados, retíralos del fuego.");
    receta.crearPaso(
        "Cuando la cebolla esté hecha, pon el pollo encima. Dale un par de vueltas.");
    receta.crearPaso(
        "Añade también la nata (puedes sustituir la nata por leche de coco) y las dos cucharadas de curry.");
    receta.crearPaso("Pon también un poco de pimienta negra.");
    receta.crearPaso(
        "Deja que se cocine todo junto hasta que la salsa espese. Cuanto más tiempo lo tengas al fuego, más espesará, así que cuando esté a tú gusto lo puedes retirar del fuego.");

    receta.crearIngrediente(2, "", "Pechuga de Pollo");
    receta.crearIngrediente(1, "", "Cebolla");
    receta.crearIngrediente(400, "ml.", "Nata");
    receta.crearIngrediente(2, "Cucharadas", "Curry");
    receta.crearIngrediente(1, "pizca", "Pimienta Negra");
    receta.crearIngrediente(1, "pizca", "Aceite Oliva");
    receta.crearIngrediente(200, "g.", "Arroz Largo");
    receta.crearIngrediente(3, "dientes", "Ajo");
    receta.crearIngrediente(1, "pizca", "Sal");
    libro.misRecetas.add(receta);
  }

  Future<void> obtenerRecetas() async {
    RecetaDB recetaDB = await RecetaDB.getReceta("1");

    // recetaDB.then((RecetaDB value) {
    //   Receta receta = Receta(value.nombre, value.nPersonas, value.duracion,
    //       'assets/PolloAlLimon.jpeg');
    //   LibroRecetas libro = LibroRecetas();

    //   libro.misRecetas.add(receta);
    // });
  }
}
