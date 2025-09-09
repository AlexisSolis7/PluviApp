import 'package:flutter/material.dart';

/// Widget para alternar entre portugués y español.
class LanguageSwitcher extends StatelessWidget {
  final String currentLanguage;
  final void Function(String) onChanged;
  const LanguageSwitcher({Key? key, required this.currentLanguage, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: currentLanguage,
      icon: const Icon(Icons.language, color: Colors.green),
      underline: Container(height: 0),
      items: const [
        DropdownMenuItem(value: 'pt', child: Text('Português (BR)')),
        DropdownMenuItem(value: 'es', child: Text('Español')),
      ],
      onChanged: (value) {
        if (value != null) onChanged(value);
      },
    );
  }
}
