import 'package:letscookit/utilities/ingrediente.dart';
import 'package:letscookit/utilities/libro_recetas.dart';
import 'package:letscookit/utilities/lista_compra.dart';
import 'package:letscookit/utilities/lista_ingredientes.dart';
import 'package:letscookit/utilities/lista_receta.dart';
import 'package:test/test.dart';

void main () {

  group('Lista Compra', (){
    test('se añade un nuevo ingrediente',(){
      ListaCompra lista = ListaCompra();
      int longitud = lista.length();
      lista.add(Ingrediente("Zanahorias"));
      
      expect(lista.length(), longitud + 1);
    });
    test('se marca un ingrediente como comprado',(){
      ListaCompra lista = ListaCompra();
      expect(lista.hayComprados(), false);
      int longitud = lista.length();
      lista.setCheck(lista.get(longitud - 1), true);
      
      expect(lista.hayComprados(), true);
    });
    test('se borran los ingredientes comprados',(){
      ListaCompra lista = ListaCompra();
      int longitud = lista.length();
      lista.borrarComprados();
      
      expect(lista.length(), longitud - 1);
    });
  });

  group('Libro Recetas', (){
    test('se añade una lista al libro de recetas', (){
      int longitud = LibroRecetas().length();
      LibroRecetas().crearLista("Nueva Lista");

      expect(LibroRecetas().length(), longitud + 1);
    });
    
    test('el libro de recetas es singleton', (){
      LibroRecetas libro1 = new LibroRecetas();
      LibroRecetas libro2 = new LibroRecetas();

      expect(libro1, libro2);

      libro2.add(new ListaReceta("nueva lista 2"));
      expect(libro1.length(), libro2.length());
    });

    test('se elimina una lista de recetas', (){ 
      int longitud = LibroRecetas().length();
      LibroRecetas().remove(LibroRecetas().get(LibroRecetas().length()-1));

      expect(LibroRecetas().length(), longitud-1);
    });

    test('se crea una receta dentro de una lista y se añade a mis recetas', (){ 
      LibroRecetas().crearLista("nueva lista");
      ListaReceta lista  = LibroRecetas().get(LibroRecetas().length() - 1);
      LibroRecetas().crearNuevaReceta(lista, "nueva receta", "", 1,1,[], [], []);

      expect(lista.get(lista.length()-1), (LibroRecetas().misRecetas.get(LibroRecetas().misRecetas.length()-1)));
    });

  });

  group('Lista Ingredientes', (){ 
    test('Se crea un nuevo ingrediente solo si no existe ya uno con el mismo nombre.', (){
      ListaIngredientes().add( Ingrediente("Zanahoria"));
      int length_1 = ListaIngredientes().length() - 1;

      ListaIngredientes().add( Ingrediente("zanahoria"));
      int length_2 = ListaIngredientes().length() - 1;

      expect(length_1, length_2);
      
    });
  
    test('Se comprueba si existe un ingrediente en la lista', (){
      bool  existe = ListaIngredientes().existeIngrediente("Aguacate");
      expect(existe, false);
    }); 

    test('La busqueda de ingredientes devuelve -1 si no existe, el indice del ingrediente buscado si existe.', (){
      int indice = ListaIngredientes().buscaIngrediente("Aguacate");
      expect(indice, -1);
      ListaIngredientes().add( Ingrediente("Zanahoria"));
      indice = ListaIngredientes().buscaIngrediente("Zanahoria");
      expect(ListaIngredientes().get(indice).nombre, "Zanahoria");
    }); 
  });
}