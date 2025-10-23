// Enum para definir quién envía el mensaje
enum ChatRole {
  user,
  assistant,
}

// Modelo para un solo mensaje en el chat
class ChatMessage {
  final String content;
  final ChatRole role;

  ChatMessage({required this.content, required this.role});


  // Convertir un ChatMessage a un Map JSON
  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'role': role.name, // Guarda 'user' o 'assistant' como string
    };
  }

  // Crear un ChatMessage desde un Map JSON
  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      content: json['content'],
      role: ChatRole.values.firstWhere(
        (e) => e.name == json['role'],
        orElse: () => ChatRole.assistant, // Default por si hay error
      ),
    );
  }
}

