import 'package:letscookit/utilities/ingrediente.dart';
import 'package:letscookit/utilities/lista.dart';

class ListaCompra {
  Map<Ingrediente, bool> _lista;
  ListaCompra._privateConstructor() : _lista = {};

  static final ListaCompra _instance = ListaCompra._privateConstructor();

  factory ListaCompra() {
    return _instance;
  }

  void add(Ingrediente ingrediente) {
    if (!lista.containsKey(ingrediente)) {
      lista[ingrediente] = false;
    }
  }

  Map<Ingrediente, bool> get lista => _lista;

  Ingrediente get(int i) {
    return lista.keys.elementAt(i);
  }

  bool getCheck(Ingrediente i) {
    if (lista.containsKey(i)) {
      return lista[i]!;
    } else {
      return false;
    }
  }

  void setCheck(Ingrediente ingrediente, bool check) {
    if (lista.containsKey(ingrediente)) {
      lista[ingrediente] = check;
    }
  }

  int length() {
    return lista.length;
  }

  void borrarComprados() {
    List<Ingrediente> aBorrar = [];
    lista.forEach((key, value) {
      if (value == true) {
        aBorrar.add(key);
      }
    });

    aBorrar.forEach((element) {
      lista.remove(element);
    });
  }

  bool hayComprados() {
    bool hayComprados = false;
    for (var comprado in lista.values) {
      if (comprado) {
        hayComprados = true;
        break;
      }
    }
    return hayComprados;
  }
}
