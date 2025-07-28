import 'package:flutter/material.dart';

class ExtsList extends StatelessWidget {
  final List<String> exts;
  final Set<String> included;
  final void Function(String ext) onToggle;

  const ExtsList({
    super.key,
    required this.exts,
    required this.included,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: exts.length,
      itemBuilder: (c, i) {
        final e = exts[i].isEmpty ? '(no ext)' : exts[i];
        final isInc = included.contains(exts[i]);
        return CheckboxListTile(
          dense: true,
          value: isInc,
          onChanged: (_) => onToggle(exts[i]),
          title: Text(e),
          controlAffinity: ListTileControlAffinity.leading,
          subtitle: isInc ? const Text('included') : null,
        );
      },
    );
  }
}
