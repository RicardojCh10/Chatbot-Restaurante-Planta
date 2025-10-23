import 'package:flutter/material.dart';
import '../core/models.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessage message;

  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.role == ChatRole.user;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Colores adaptables al tema
    final bgColor = isUser
        ? colorScheme.primaryContainer
        : colorScheme.surfaceVariant;
    final textColor = isUser
        ? colorScheme.onPrimaryContainer
        : colorScheme.onSurfaceVariant;

    return Align(
      // Alineamos a la derecha (user) o izquierda (assistant)
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0),
        decoration: BoxDecoration(
          // Colores adaptados al tema
          color: bgColor,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16.0),
            topRight: const Radius.circular(16.0),
            bottomLeft:
                isUser ? const Radius.circular(16.0) : Radius.zero,
            bottomRight:
                isUser ? Radius.zero : const Radius.circular(16.0),
          ),
          boxShadow: [
            BoxShadow(
              // Sombra sutil que funciona en ambos modos
              color: theme.shadowColor.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        // Limitamos el ancho máximo de la burbuja
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        child: Text(
          message.content,
          style: TextStyle(
            color: textColor, // Color adaptado
          ),
        ),
      ),
    );
  }
}

