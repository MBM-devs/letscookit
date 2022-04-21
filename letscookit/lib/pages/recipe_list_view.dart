import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:letscookit/config/palette.dart';
import 'package:letscookit/utilities/libro_recetas.dart';
import 'package:letscookit/utilities/lista_receta.dart';
import 'package:letscookit/utilities/receta.dart';

class RecipeListView extends StatefulWidget {
  ListaReceta _lista;

  RecipeListView({Key? key})
      : _lista = LibroRecetas().misRecetas,
        super(key: key);
  RecipeListView.conLista(this._lista, {Key? key}) : super(key: key);

  @override
  _RecipeListViewState createState() => _RecipeListViewState(this._lista);
}

class _RecipeListViewState extends State<RecipeListView> {
  CarouselController _carouselController = new CarouselController();
  int _current = 0;
  ListaReceta _recetas;

  _RecipeListViewState(this._recetas);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // Restamos altura de Appbar y navigation
      height: MediaQuery.of(context).size.height - 120,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          // Image.network(_movies[_current]['image'], fit: BoxFit.fitHeight),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                    Palette.mainBlue.shade800.withOpacity(1.0),
                    Palette.mainBlue.shade700.withOpacity(1.0),
                    Palette.mainBlue.shade600.withOpacity(1.0),
                    Palette.mainBlue.shade500.withOpacity(1.0),
                    Palette.mainBlue.shade400.withOpacity(1.0),
                    Palette.mainBlue.shade200.withOpacity(1.0),
                    Palette.mainBlue.shade100.withOpacity(1.0),
                    Palette.mainBlue.shade50.withOpacity(1.0),

                    // Colors.grey.shade50.withOpacity(1),
                    // Colors.grey.shade50.withOpacity(1),
                    // Colors.grey.shade50.withOpacity(1),
                    // Colors.grey.shade50.withOpacity(1),

                    // Colors.grey.shade50.withOpacity(0.0),
                    // Colors.grey.shade50.withOpacity(0.0),
                    // Colors.grey.shade50.withOpacity(0.0),
                    // Colors.grey.shade50.withOpacity(0.0),
                  ])),
            ),
          ),
          Positioned(
            bottom: 50,
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width,
            child: CarouselSlider(
              options: CarouselOptions(
                height: 450.0,
                aspectRatio: 16 / 9,
                viewportFraction: 0.70,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                },
              ),
              carouselController: _carouselController,
              items: _recetas.lista.map((receta) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                height: 320,
                                margin: EdgeInsets.only(top: 30),
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Image.asset(receta.imagen,
                                    fit: BoxFit.cover),
                              ),
                              SizedBox(height: 20),
                              Text(
                                receta.nombre,
                                style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              // rating
                              SizedBox(height: 20),

                              Padding(
                                padding: EdgeInsets.only(left: 60),
                                child: AnimatedOpacity(
                                  duration: Duration(milliseconds: 500),
                                  opacity:
                                      _current == _recetas.lista.indexOf(receta)
                                          ? 1.0
                                          : 0.0,
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.person_rounded,
                                                color: Color.fromARGB(
                                                    255, 117, 117, 117),
                                                size: 20,
                                              ),
                                              const SizedBox(width: 5),
                                              Text(
                                                receta.numPersonas.toString(),
                                                style: TextStyle(
                                                    fontSize: 14.0,
                                                    color:
                                                        Colors.grey.shade600),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.access_time_rounded,
                                                color: Colors.grey.shade600,
                                                size: 20,
                                              ),
                                              SizedBox(width: 5),
                                              Text(
                                                receta.duracion.toString() +
                                                    " min",
                                                style: TextStyle(
                                                    fontSize: 14.0,
                                                    color:
                                                        Colors.grey.shade600),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.remove_red_eye_rounded,
                                                color: Colors.grey.shade600,
                                                size: 20,
                                              ),
                                              SizedBox(width: 5),
                                              Text(
                                                'Ver',
                                                style: TextStyle(
                                                    fontSize: 14.0,
                                                    color:
                                                        Colors.grey.shade600),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ));
                  },
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}
