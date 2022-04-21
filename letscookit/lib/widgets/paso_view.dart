import 'package:flutter/material.dart';
import 'package:letscookit/utilities/paso.dart';

class PasoView extends StatefulWidget {
  final int index;
  Paso _paso;
  PasoView(this.index, this._paso);

  @override
  _PasoViewState createState() => _PasoViewState();
}

class _PasoViewState extends State<PasoView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, right: 60),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${widget.index + 1}.",
            style: const TextStyle(color: Colors.grey, fontSize: 15),
          ),
          const SizedBox(width: 5),
          Flexible(
              child: Text(
            widget._paso.descripcion,
            textAlign: TextAlign.justify,
            style: const TextStyle(fontSize: 15),
          ))
        ],
      ),
    );
  }
}
