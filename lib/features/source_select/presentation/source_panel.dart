import 'package:flutter/material.dart';
import 'widgets/source_input_field.dart';

/// Верхняя строка: поле источника + справа одна кнопка.
/// На мобилке — Scan, на десктопе — Choose & Scan.
class SourcePanel extends StatelessWidget {
  final String initialText;
  final List<String> suggestions;
  final ValueChanged<String> onSubmit;
  final bool isMobile;
  final VoidCallback onScan;
  final VoidCallback onPickAndScan;

  const SourcePanel({
    super.key,
    required this.initialText,
    required this.suggestions,
    required this.onSubmit,
    required this.isMobile,
    required this.onScan,
    required this.onPickAndScan,
  });

  @override
  Widget build(BuildContext context) {
    final button = isMobile
        ? FilledButton.icon(
            onPressed: onScan,
            icon: const Icon(Icons.search),
            label: const Text('Scan'),
          )
        : OutlinedButton.icon(
            onPressed: onPickAndScan,
            icon: const Icon(Icons.folder_open),
            label: const Text('Choose & Scan'),
          );
    return Row(
      children: [
        Expanded(
          child: SourceInputField(
            initialText: initialText,
            suggestions: suggestions,
            onSubmit: onSubmit,
          ),
        ),
        const SizedBox(width: 12),
        button,
      ],
    );
  }
}
