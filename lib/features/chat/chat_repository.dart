import '../../core/api_client.dart';
import '../../core/models.dart';

class ChatRepository {
  final ApiClient _apiClient;

  ChatRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  // Llama al endpoint /chat
  Future<String> ask(String message, List<ChatMessage> history) async {
    // Se convierte el historial a formato adecuado
    final historyPayload = history
        .map((msg) => {
              'role': msg.role == ChatRole.user ? 'user' : 'assistant',
              'content': msg.content,
            })
        .toList();

    // se crea el body de la petición
    final requestBody = {
      'message': message,
      'history': [], 
    };

    try {
      // Se hace el POST
      final response = await _apiClient.post('/chat', requestBody);

      // Se extrae la respuesta
      if (response.containsKey('answer')) {
        return response['answer'] as String;
      } else {
        throw Exception('Formato de respuesta inesperado');
      }
    } catch (e) {
      // Re-lanzamos el error para que el Controller lo maneje
      throw Exception('Error al contactar al backend: $e');
    }
  }
}

