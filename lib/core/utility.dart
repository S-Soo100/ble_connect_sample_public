mixin Utility {
  String cleanString(String input) {
    return input.replaceAll(RegExp(r'[^0-9]'), '');
  }
}
