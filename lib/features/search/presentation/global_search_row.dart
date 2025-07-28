import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../project_browser/application/browser_state_controller.dart';
import '../application/global_search.dart';
import '../application/jump_to_file.dart';

class GlobalSearchRow extends ConsumerStatefulWidget {
  final bool isMobile;
  const GlobalSearchRow({super.key, required this.isMobile});

  @override
  ConsumerState<GlobalSearchRow> createState() => _GlobalSearchRowState();
}

class _GlobalSearchRowState extends ConsumerState<GlobalSearchRow> {
  final _ctrl = TextEditingController();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Future<void> _run() async {
    final q = _ctrl.text.trim();
    if (q.isEmpty) return;

    final res = await ref.read(globalSearchProvider(query: q).future);
    if (!mounted) return;

    if (res.skippedLarge.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Skipped ${res.skippedLarge.length} large files'),
        ),
      );
    }

    showDialog(
      context: context,
      builder: (c) {
        return AlertDialog(
          title: Text('Search: "${res.query}" — ${res.hits.length} files'),
          content: SizedBox(
            width: 720,
            height: 480,
            child: res.hits.isEmpty
                ? const Center(child: Text('No matches'))
                : ListView.builder(
                    itemCount: res.hits.length,
                    itemBuilder: (c, i) {
                      final h = res.hits[i];
                      return ListTile(
                        dense: true,
                        title: Text(h.path),
                        trailing: CircleAvatar(
                          radius: 12,
                          child: Text(h.count.toString()),
                        ),
                        onTap: () {
                          final st = ref
                              .read(browserStateControllerProvider)
                              .asData
                              ?.value;
                          if (st != null) {
                            final sel = {...st.selectedPaths};
                            sel.add(h.path);
                            ref
                                .read(browserStateControllerProvider.notifier)
                                .setSelectedPaths(sel.toList());
                          }
                          Navigator.of(c).pop();

                          if (widget.isMobile) {
                            GoRouter.of(context).go('/viewer', extra: [h.path]);
                          } else {
                            ref
                                .read(searchJumpProvider.notifier)
                                .set(JumpCommand(h.path, res.query));
                          }
                        },
                      );
                    },
                  ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                final st = ref
                    .read(browserStateControllerProvider)
                    .asData
                    ?.value;
                if (st != null) {
                  final add = res.hits.map((e) => e.path);
                  final sel = {...st.selectedPaths}..addAll(add);
                  ref
                      .read(browserStateControllerProvider.notifier)
                      .setSelectedPaths(sel.toList());
                }
                Navigator.of(c).pop();
              },
              child: const Text('Select all'),
            ),
            TextButton(
              onPressed: () => Navigator.of(c).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _ctrl,
            decoration: const InputDecoration(
              isDense: true,
              hintText: 'Search in project…',
              border: OutlineInputBorder(),
            ),
            onSubmitted: (_) => _run(),
          ),
        ),
        const SizedBox(width: 12),
        FilledButton.icon(
          onPressed: _run,
          icon: const Icon(Icons.search),
          label: const Text('Search'),
        ),
      ],
    );
  }
}
