import 'package:flutter/material.dart';
import '../../core/models.dart';
import '../../core/storage_service.dart';
import 'chat_repository.dart';

class ChatController with ChangeNotifier {
  final ChatRepository _repository;
  final StorageService _storageService; 

  ChatController({
    required ChatRepository repository,
    required StorageService storageService,
  })  : _repository = repository,
        _storageService = storageService {
    _loadInitialMessages(); // se carga el mensaje al iniciar
  }

  // Estado 
  List<ChatMessage> _messages = []; // Modificación para ser mutable
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  List<ChatMessage> get messages => _messages;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Método para cargar mensajes desde el storage
  void _loadInitialMessages() {
    _messages = _storageService.loadMessages();
    notifyListeners();
  }

  // Método principal para enviar un mensaje
  Future<void> sendMessage(String text) async {
    final trimmedText = text.trim();
    if (trimmedText.isEmpty) return;

    final userMessage = ChatMessage(content: trimmedText, role: ChatRole.user);
    _messages.add(userMessage);

    _isLoading = true;
    _errorMessage = null; // Limpiar errores previos
    notifyListeners(); // Se notifica a la UI

    // Guardar historial (incluyendo el mensaje del usuario)
    await _storageService.saveMessages(_messages);

    try {
      //  Se obtiene el historial actual
      final history =
          List<ChatMessage>.from(_messages.sublist(0, _messages.length - 1));

      // Se llama l repositorio para obtener la respuesta
      final assistantResponse = await _repository.ask(trimmedText, history);

      //  Añadir respuesta del asistente
      final assistantMessage =
          ChatMessage(content: assistantResponse, role: ChatRole.assistant);
      _messages.add(assistantMessage);

      //   Se guarda el historial con la respuesta del bot
      await _storageService.saveMessages(_messages);
      
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners(); // Notificar a la UI
    }
  }
}

