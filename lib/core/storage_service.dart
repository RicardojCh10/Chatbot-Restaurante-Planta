import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'models.dart';

class StorageService {
  final SharedPreferences _prefs;

  static const _messagesKey = 'chat_messages';
  static const _themeKey = 'is_dark_mode'; 

  StorageService({required SharedPreferences prefs}) : _prefs = prefs;

  // Historial de mensajes

  Future<void> saveMessages(List<ChatMessage> messages) async {
    try {
      final List<Map<String, dynamic>> messagesJson =
          messages.map((msg) => msg.toJson()).toList();
      await _prefs.setString(_messagesKey, jsonEncode(messagesJson));
    } catch (e) {
      print('Error al guardar mensajes: $e');
    }
  }

  List<ChatMessage> loadMessages() {
    try {
      final String? messagesString = _prefs.getString(_messagesKey);
      if (messagesString == null) {
        return [];
      }
      final List<dynamic> messagesJson = jsonDecode(messagesString);
      return messagesJson
          .map((json) => ChatMessage.fromJson(json))
          .toList();
    } catch (e) {
      print('Error al cargar mensajes: $e');
      return [];
    }
  }

  // Tema (modo claro/oscuro)

  Future<void> saveThemeMode(bool isDarkMode) async {
    await _prefs.setBool(_themeKey, isDarkMode);
  }

  bool loadThemeMode() {
    return _prefs.getBool(_themeKey) ?? false;
  }
}

