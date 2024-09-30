String? ValidateChampPayement(String? value) {
  if (value == null || value.isEmpty) {
    return 'Le champ ne peut pas être vide';
  }
  if (!RegExp(r'^\d{10}$').hasMatch(value)) {
    return 'Le champ doit contenir exactement 10 chiffres';
  }
  return null;
}
