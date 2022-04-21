import 'package:flutter/material.dart';
import 'package:letscookit/config/palette.dart';
import 'package:letscookit/utilities/ingrediente.dart';
import 'package:letscookit/utilities/lista_compra.dart';
import 'package:letscookit/utilities/lista_ingredientes.dart';
import 'package:searchfield/searchfield.dart';

class SearchBar extends SearchField {
  SearchBar(
      {Key? key,
      required List<SearchFieldListItem<Ingrediente>> suggestions,
      TextEditingController? controller,
      String? hint,
      Function(SearchFieldListItem<dynamic>)? onSuggestionTap,
      Function(String)? onSubmit})
      : super(
          key: key,
          controller: controller,
          suggestions: suggestions,
          hint: hint,
          onSuggestionTap: onSuggestionTap,
          onSubmit: onSubmit,
          searchInputDecoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blueGrey.shade200,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: Palette.mainBlue.shade400,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          maxSuggestionsInViewPort: 6,
          itemHeight: 50,
          suggestionsDecoration: BoxDecoration(
            color: Palette.mainBlue.shade600,
            borderRadius: BorderRadius.circular(10),
          ),
        );
}
