import 'package:flutter/material.dart';

class InputBar extends StatefulWidget {
  final bool isLoading;
  final Function(String) onSend;

  const InputBar({
    super.key,
    required this.isLoading,
    required this.onSend,
  });

  @override
  State<InputBar> createState() => _InputBarState();
}

class _InputBarState extends State<InputBar> {
  // Controlador para limpiar el texto
  final TextEditingController _textController = TextEditingController();

  void _handleSend() {
    final text = _textController.text.trim();
    if (text.isNotEmpty) {
      widget.onSend(text);
      _textController.clear();
      // Opcional: quitar foco para ocultar teclado
      FocusScope.of(context).unfocus();
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: theme.colorScheme.surface,
      elevation: 5.0,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: SafeArea(
          child: Row(
            children: [
              // Campo de Texto
              Expanded(
                child: TextField(
                  controller: _textController,
                  enabled: !widget.isLoading,
                  decoration: InputDecoration(
                    hintText: 'Escribe tu pregunta...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    // Color de fondo adaptable
                    fillColor: theme.colorScheme.surfaceVariant.withOpacity(0.5),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 10.0),
                  ),
                  // Permite enviar con la tecla "Enter" en web/desktop
                  onSubmitted: (text) => _handleSend(),
                ),
              ),
              const SizedBox(width: 8.0),
              // --- Botón de Enviar ---
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: widget.isLoading ? null : _handleSend,
                style: IconButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.onPrimary,
                  padding: const EdgeInsets.all(12.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

