import 'dart:html';

import 'package:flutter/material.dart';

class MyScaffold extends Scaffold {
  Widget _pagina;
  String _titulo;
  static int current = 0;

  MyScaffold(this._pagina, this._titulo, {Key? key, Widget? child})
      : super(
          key: key,
          appBar: AppBar(
            toolbarHeight: 60,
            title: Text(_titulo),
          ),
          body: SingleChildScrollView(child: _pagina),
          bottomNavigationBar: child,
        );
}
