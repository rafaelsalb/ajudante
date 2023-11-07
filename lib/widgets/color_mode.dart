import 'package:flutter/material.dart';

class ColorMode extends ChangeNotifier {
  ColorScheme _colorScheme = const ColorScheme.light();

  ColorScheme get colorScheme => _colorScheme;

  void switchColorScheme() {
    if (_colorScheme == const ColorScheme.light()) {
      _colorScheme = const ColorScheme.dark();
    } else if (_colorScheme == const ColorScheme.dark()) {
      _colorScheme = const ColorScheme.light();
    }
    notifyListeners();
  }
}
