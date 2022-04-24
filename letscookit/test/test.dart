import 'package:letscookit/utilities/ingrediente.dart';
import 'package:letscookit/utilities/lista_compra.dart';
import 'package:test/test.dart';

void main () {

  group('Lista_Compra', (){
    test('se añade un nuevo ingrediente',(){
      ListaCompra lista = ListaCompra();
      int longitud = lista.length();
      lista.add(Ingrediente("Zanahorias"));
      
      expect(lista.length(), longitud + 1);
    });
    test('ingrediente comprado',(){
      ListaCompra lista = ListaCompra();
      expect(lista.hayComprados(), false);
      int longitud = lista.length();
      lista.setCheck(lista.get(longitud - 1), true);
      
      expect(lista.hayComprados(), true);
    });
    
    test('ingrediente comprados borrados',(){
      ListaCompra lista = ListaCompra();
      int longitud = lista.length();
      lista.borrarComprados();
      
      expect(lista.length(), longitud - 1);
    });
  });
}