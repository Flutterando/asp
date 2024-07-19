import 'package:flutter/material.dart';

enum SymbolIcon {
  home(Icons.home);

  // constructor
  final IconData data;
  const SymbolIcon(this.data);

  // adapters
  static SymbolIcon fromString(String value) {
    return SymbolIcon.values.firstWhere(
      (e) => e.name == value,
      orElse: () => SymbolIcon.home,
    );
  }
}
