String? ValidateChampConsumer(String? value) {
  if (value == null || value.isEmpty) {
    return 'Le champ ne peut pas être vide';
  }
  if (!RegExp(r'^[a-zA-Z]').hasMatch(value)) {
    return 'Le champ doit commencer par une lettre';
  }
  return null;
}