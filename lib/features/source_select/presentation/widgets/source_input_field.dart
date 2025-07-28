import 'package:flutter/material.dart';

class SourceInputField extends StatefulWidget {
  final ValueChanged<String> onSubmit;
  final List<String> suggestions;
  final String initialText;

  const SourceInputField({
    super.key,
    required this.onSubmit,
    this.suggestions = const [],
    this.initialText = '',
  });

  @override
  State<SourceInputField> createState() => _SourceInputFieldState();
}

class _SourceInputFieldState extends State<SourceInputField> {
  String _lastInjected = '';

  @override
  Widget build(BuildContext context) {
    return RawAutocomplete<String>(
      optionsBuilder: (t) {
        final q = t.text.trim();
        if (q.isEmpty) return const Iterable<String>.empty();
        return widget.suggestions.where(
          (s) => s.toLowerCase().contains(q.toLowerCase()),
        );
      },
      onSelected: widget.onSubmit,
      fieldViewBuilder: (c, textCtrl, focus, onFieldSubmitted) {
        // Однократно (или при изменении) прокидываем исходный текст.
        if (widget.initialText.isNotEmpty &&
            widget.initialText != _lastInjected &&
            textCtrl.text != widget.initialText) {
          textCtrl.text = widget.initialText;
          _lastInjected = widget.initialText;
        }

        return TextField(
          controller: textCtrl,
          focusNode: focus,
          decoration: const InputDecoration(
            labelText: 'Local Path or GitHub API URL or owner/repo[#branch]',
            border: OutlineInputBorder(),
          ),
          onSubmitted: widget.onSubmit,
        );
      },
      optionsViewBuilder: (c, onSelected, options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 240, maxWidth: 720),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: options.length,
                itemBuilder: (c, i) {
                  final v = options.elementAt(i);
                  return ListTile(
                    dense: true,
                    title: Text(v),
                    onTap: () => onSelected(v),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
