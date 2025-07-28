import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../project_browser/application/browser_state_controller.dart';
import '../../content_viewer/presentation/editors_pane.dart';

// было: import 'source_panel.dart'; import 'filters_pane.dart';
import '../../source_select/presentation/source_panel.dart';
import '../../project_browser/presentation/filters_pane.dart';

/// Мобильный макет: поле ввода источника + FiltersPane.
class MobileLayout extends ConsumerWidget {
  final String lastInput;
  final List<String> suggestions;
  final ValueChanged<String> onSubmitInput;
  final VoidCallback onScan;
  final VoidCallback onPickAndScan;

  const MobileLayout({
    super.key,
    required this.lastInput,
    required this.suggestions,
    required this.onSubmitInput,
    required this.onScan,
    required this.onPickAndScan,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          SourcePanel(
            initialText: lastInput,
            suggestions: suggestions,
            onSubmit: onSubmitInput,
            isMobile: true,
            onScan: onScan,
            onPickAndScan: onPickAndScan,
          ),
          const SizedBox(height: 16),
          const Expanded(child: FiltersPane(isMobile: true)),
        ],
      ),
    );
  }
}

/// Десктопный макет: слева фильтры, справа – редакторы выбранных файлов.
class DesktopLayout extends ConsumerWidget {
  final String lastInput;
  final List<String> suggestions;
  final ValueChanged<String> onSubmitInput;
  final VoidCallback onScan;
  final VoidCallback onPickAndScan;

  const DesktopLayout({
    super.key,
    required this.lastInput,
    required this.suggestions,
    required this.onSubmitInput,
    required this.onScan,
    required this.onPickAndScan,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateAsync = ref.watch(browserStateControllerProvider);
    final s = stateAsync.asData?.value;

    final Widget rightPane = (s == null || s.selectedPaths.isEmpty)
        ? const Center(child: Text('No files selected'))
        : EditorsPane(paths: s.selectedPaths);

    return Row(
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SourcePanel(
                  initialText: lastInput,
                  suggestions: suggestions,
                  onSubmit: onSubmitInput,
                  isMobile: false,
                  onScan: onScan,
                  onPickAndScan: onPickAndScan,
                ),
                const SizedBox(height: 16),
                const Expanded(child: FiltersPane(isMobile: false)),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 7,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: rightPane,
          ),
        ),
      ],
    );
  }
}
