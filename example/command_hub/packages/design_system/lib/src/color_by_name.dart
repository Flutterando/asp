import 'dart:ui';

class ColorByName {
  ColorByName._();

  static ColorScheme getSchemeByText(String text) {
    final code = text.runes.reduce((value, element) => value + element);
    var count = code % (_colorSchemes.length);
    return _colorSchemes[count];
  }
}

final _colorSchemes = [
  ColorScheme(
    const Color.fromARGB(255, 113, 90, 154),
    const Color.fromARGB(255, 95, 70, 141),
  ),
  ColorScheme(
    const Color.fromARGB(255, 137, 145, 154),
    const Color.fromARGB(255, 121, 130, 140),
  ),
  ColorScheme(
    const Color.fromARGB(255, 226, 196, 75),
    const Color.fromARGB(255, 222, 188, 51),
  ),
  ColorScheme(
    const Color.fromARGB(255, 223, 111, 111),
    const Color.fromARGB(255, 219, 92, 92),
  ),
  ColorScheme(
    const Color.fromARGB(255, 74, 199, 171),
    const Color.fromARGB(255, 39, 191, 162),
  ),
  ColorScheme(
    const Color.fromARGB(255, 105, 191, 101),
    const Color.fromARGB(255, 88, 184, 84),
  ),
];

class ColorScheme {
  final Color startColor;
  final Color endColor;

  ColorScheme(this.startColor, this.endColor);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ColorScheme && other.startColor == startColor && other.endColor == endColor;
  }

  @override
  int get hashCode => startColor.hashCode ^ endColor.hashCode;
}
