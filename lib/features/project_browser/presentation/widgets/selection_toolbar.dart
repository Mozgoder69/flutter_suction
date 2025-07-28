import 'package:flutter/material.dart';

class SelectionToolbar extends StatelessWidget {
  final bool allSelected;
  final VoidCallback onToggleSelectAll;
  final VoidCallback onSave;
  final VoidCallback onLoad;
  final VoidCallback onExtract;
  final bool showExtract;

  const SelectionToolbar({
    super.key,
    required this.allSelected,
    required this.onToggleSelectAll,
    required this.onSave,
    required this.onLoad,
    required this.onExtract,
    this.showExtract = true,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        FilledButton.tonal(
          onPressed: onToggleSelectAll,
          child: Text(allSelected ? 'Deselect all' : 'Select all'),
        ),
        FilledButton(onPressed: onSave, child: const Text('Save selection')),
        FilledButton(onPressed: onLoad, child: const Text('Load selection')),
        if (showExtract)
          FilledButton(onPressed: onExtract, child: const Text('Extract')),
      ],
    );
  }
}
