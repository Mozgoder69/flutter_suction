import 'package:flutter/material.dart';

class DirsList extends StatelessWidget {
  final List<String> dirs;
  final Set<String> excluded;
  final void Function(String dir) onToggle;

  const DirsList({
    super.key,
    required this.dirs,
    required this.excluded,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dirs.length,
      itemBuilder: (c, i) {
        final d = dirs[i];
        final isExcluded = excluded.contains(d);
        return CheckboxListTile(
          dense: true,
          value: isExcluded,
          onChanged: (_) => onToggle(d),
          title: Text(d),
          controlAffinity: ListTileControlAffinity.leading,
          subtitle: isExcluded ? const Text('excluded') : null,
        );
      },
    );
  }
}
