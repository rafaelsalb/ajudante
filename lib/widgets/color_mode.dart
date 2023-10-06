import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ColorMode extends ChangeNotifier {
  ColorScheme _colorScheme = ColorScheme.light();

  ColorScheme get colorScheme => _colorScheme;

  void switchColorScheme() {
    if (_colorScheme == ColorScheme.light()) {
      _colorScheme = ColorScheme.dark();
    } else if (_colorScheme == ColorScheme.dark()) {
      _colorScheme = ColorScheme.light();
    }
    notifyListeners();
  }
}
