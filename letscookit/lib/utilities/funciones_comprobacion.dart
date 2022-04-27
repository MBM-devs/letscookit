String removeDiacritics(String str) {
  var withDia =
      'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
  var withoutDia =
      'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz';

  for (int i = 0; i < withDia.length; i++) {
    str = str.replaceAll(withDia[i], withoutDia[i]);
  }

  return str;
}

bool nombreValido(String nombre, dynamic object) {
  bool nombreValido = true;
  for (int i = 0; i < object.length() && nombreValido; i++) {
    if (removeDiacritics(nombre.toLowerCase()) ==
        removeDiacritics(object.get(i).nombre.toLowerCase())) {
      nombreValido = false;
    }
  }
  return nombreValido;
}
