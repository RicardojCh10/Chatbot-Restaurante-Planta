import 'package:flutter/material.dart';
import 'storage_service.dart';

class ThemeController with ChangeNotifier {
  final StorageService _storageService;
  late bool _isDarkMode;

  ThemeController({required StorageService storageService})
      : _storageService = storageService {
    // Cargamos la preferencia de tema guardada
    _isDarkMode = _storageService.loadThemeMode();
  }

  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;
  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _storageService.saveThemeMode(_isDarkMode); // Guardamos la preferencia
    notifyListeners();
  }
}
