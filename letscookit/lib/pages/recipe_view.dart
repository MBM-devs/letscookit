import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:letscookit/config/palette.dart';
import 'package:letscookit/utilities/lista_receta.dart';
import 'package:letscookit/utilities/receta.dart';
import 'package:letscookit/widgets/paso_view.dart';
import 'package:letscookit/widgets/recipe_image.dart';

class RecipeView extends StatefulWidget {
  Receta _receta;
  RecipeView(this._receta, {Key? key}) : super(key: key);

  @override
  State<RecipeView> createState() => _RecipeViewState(this._receta);
}

class _RecipeViewState extends State<RecipeView> {
  CarouselController _carouselController = new CarouselController();
  int _current = 0;
  Receta _receta;

  _RecipeViewState(this._receta);
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 120,
          // margin: const EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
            color: Palette.mainBlue.shade900,
            // borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            children: [
              RecipeImage(_receta.imagen),
              SizedBox(height: 20),
              Text(
                _receta.nombre,
                style: const TextStyle(
                    fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              // rating
              SizedBox(height: 20),

              Padding(
                padding: EdgeInsets.only(left: 60),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            const Icon(
                              Icons.person_rounded,
                              color: Color.fromARGB(255, 117, 117, 117),
                              size: 20,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              _receta.numPersonas.toString(),
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.grey.shade600),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: Row(
                          children: [
                            Icon(
                              Icons.access_time_rounded,
                              color: Colors.grey.shade600,
                              size: 20,
                            ),
                            SizedBox(width: 5),
                            Text(
                              _receta.duracion.toString() + " min",
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.grey.shade600),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(left: 80.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Pasos: ",
                      style: const TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    ...getPasos()
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<PasoView> getPasos() {
    List<PasoView> pasos = [];
    for (var i = 0; i < _receta.numPasos; i++) {
      pasos.add(PasoView(i, _receta.getPaso(i)));
    }
    return pasos;
  }
}
