import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/platform/pick_directory.dart';
import '../../status/presentation/progress_bar.dart';
import '../../status/application/progress_controller.dart';
import '../../status/domain/progress_state.dart';
import '../../selections/application/selections_controller.dart';
import '../../project_browser/application/browser_state_controller.dart';
import '../../source_select/application/source_controller.dart';

// Вынесенные крупные виджеты (макеты, фильтры, поиск, панель источника)
import 'workbench_panes.dart';

class WorkbenchPage extends ConsumerStatefulWidget {
  const WorkbenchPage({super.key});

  @override
  ConsumerState<WorkbenchPage> createState() => _WorkbenchPageState();
}

class _WorkbenchPageState extends ConsumerState<WorkbenchPage> {
  String _lastInput = '';

  bool get _isHandset {
    final size = MediaQuery.sizeOf(context);
    return size.height > size.width;
  }

  Future<void> _setInputAndMaybeScan(String value, {bool scan = false}) async {
    _lastInput = value;
    ref.read(sourceControllerProvider.notifier).setInput(value);
    setState(() {});
    if (scan) await _scan();
  }

  Future<void> _pickDirectoryAndScan() async {
    final path = await pickDirectory();
    if (path == null || path.isEmpty) return;
    await _setInputAndMaybeScan(path, scan: true);
  }

  Future<void> _scan() async {
    final p = ref.read(progressControllerProvider.notifier);
    p
      ..setMessage('Scanning project')
      ..setLevel(StatusLevel.info)
      ..setValue(10);
    ref.invalidate(browserStateControllerProvider);
  }

  @override
  Widget build(BuildContext context) {
    // // Слушаем прогресс сканирования дерева
    // ref.listen(browserStateControllerProvider, (prev, next) {
    //   final p = ref.read(progressControllerProvider.notifier);
    //   next.when(
    //     data: (_) {
    //       p
    //         ..setMessage('Scanning Complete')
    //         ..setLevel(StatusLevel.pass)
    //         ..setValue(100);
    //     },
    //     loading: () {
    //       p
    //         ..setMessage('Scanning project')
    //         ..setLevel(StatusLevel.info)
    //         ..setValue(40);
    //     },
    //     error: (e, _) {
    //       p
    //         ..setMessage('Scanning Error')
    //         ..setLevel(StatusLevel.fail)
    //         ..setValue(0);
    //     },
    //   );
    // });

    // Синхронизируем поле ввода с текущим SourceSpec
    final spec = ref.watch(sourceControllerProvider);
    final specStr = spec?.toString() ?? '';
    if (specStr.isNotEmpty && specStr != _lastInput) {
      _lastInput = specStr;
    }

    final store = ref.watch(selectionsStoreProvider);
    final labelStyle = Theme.of(context).textTheme.titleSmall;

    return FutureBuilder<List<String>>(
      future: store.listProjects(),
      builder: (c, snap) {
        final suggestions = snap.data ?? const <String>[];
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 44,
            titleSpacing: 16,
            title: Row(
              children: [
                const Expanded(child: InlineProgressBar()),
                TextButton.icon(
                  onPressed: () => context.go('/settings'),
                  icon: const Icon(Icons.settings, size: 20),
                  label: Text('Settings', style: labelStyle),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    foregroundColor: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
          body: _isHandset
              ? MobileLayout(
                  lastInput: _lastInput,
                  suggestions: suggestions,
                  onSubmitInput: (v) => _setInputAndMaybeScan(v),
                  onScan: _scan,
                  onPickAndScan: _pickDirectoryAndScan,
                )
              : DesktopLayout(
                  lastInput: _lastInput,
                  suggestions: suggestions,
                  onSubmitInput: (v) => _setInputAndMaybeScan(v),
                  onScan: _scan,
                  onPickAndScan: _pickDirectoryAndScan,
                ),
        );
      },
    );
  }
}
