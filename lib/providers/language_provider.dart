import 'package:flutter/material.dart';

class LanguageProvider with ChangeNotifier {
  bool _isHindi = false;

  bool get isHindi => _isHindi;

  void toggleLanguage() {
    _isHindi = !_isHindi;
    notifyListeners();
  }
}
