import 'package:flutter/material.dart';

/// Widget para mostrar mensajes motivacionales o educativos.
class MotivationalMessage extends StatelessWidget {
  final String message;
  const MotivationalMessage({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.lightBlue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Row(
        children: [
          const Icon(Icons.emoji_objects, color: Colors.green, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(fontSize: 16, color: Colors.blueAccent),
            ),
          ),
        ],
      ),
    );
  }
}
