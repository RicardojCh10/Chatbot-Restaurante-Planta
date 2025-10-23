import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/../core/theme_controller.dart';
import 'chat_controller.dart';
import '/widgets/input_bar.dart';
import '/widgets/message_bubble.dart';
import '/widgets/typing_indicator.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final controller = context.read<ChatController>();
    controller.addListener(_scrollToBottom);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    context.read<ChatController>().removeListener(_scrollToBottom);
    super.dispose();
  }

  // Método para hacer scroll al final de la lista
  void _scrollToBottom() {
    // se usa un post-frame callback para asegurar que el widget de lista
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Observamos los cambios en el ChatController
    final controller = context.watch<ChatController>();
    // Observamos el ThemeController para el ícono
    final themeController = context.watch<ThemeController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chatbot RAG'),
        actions: [
          //  Botón de cambio de tema 
          IconButton(
            icon: Icon(
              themeController.isDarkMode
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode_outlined,
            ),
            onPressed: () {
              context.read<ThemeController>().toggleTheme();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          //  Lista de Mensajes
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(8.0),
              itemCount: controller.messages.length,
              itemBuilder: (context, index) {
                final message = controller.messages[index];
                return MessageBubble(message: message);
              },
            ),
          ),

          //  Indicador de "Pensando..."
          if (controller.isLoading)
            const TypingIndicator(),

          //  Mensaje de Error
          if (controller.errorMessage != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                controller.errorMessage!,
                // Color de error adaptable al tema
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),

          //  Barra de Entrada 
          InputBar(
            isLoading: controller.isLoading,
            onSend: (text) {
              // Llamamos al método del controller
              controller.sendMessage(text);
            },
          ),
        ],
      ),
    );
  }
}