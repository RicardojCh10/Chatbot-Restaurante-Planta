import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart'; 
class TypingIndicator extends StatelessWidget {
  const TypingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      child: Row(
        children: [
          // Animación de "escribiendo"
          SpinKitThreeBounce(
            // Color adaptable
            color: theme.textTheme.bodySmall?.color?.withOpacity(0.6),
            size: 18.0,
          ),
          const SizedBox(width: 12.0),
          // Texto
          Text(
            'Preparando respuesta...',
            style: TextStyle(
              // Color adaptable
              color: theme.textTheme.bodySmall?.color?.withOpacity(0.8),
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

