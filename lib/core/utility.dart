mixin Utility {
  String cleanString(String input) {
    return input.replaceAll(RegExp(r'[^0-9]'), '');
  }

  int clearInt(String input) {
    return int.parse(cleanString(input));
  }
}
