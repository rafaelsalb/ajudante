import 'package:flutter/material.dart';

class TodoFilter extends ChangeNotifier {
  bool _only_done = false;

  bool get only_done => _only_done;

  void switch_filter() {
    _only_done = !_only_done;
    notifyListeners();
  }
}