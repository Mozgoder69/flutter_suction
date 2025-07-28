import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../status/application/progress_controller.dart';
import '../../status/domain/progress_state.dart';
import '../../selections/application/selections_controller.dart';

import '../application/browser_state_controller.dart';
import 'widgets/dirs_list.dart';
import 'widgets/exts_list.dart';
import 'widgets/files_list.dart';
import 'widgets/selection_toolbar.dart';

class FiltersPane extends ConsumerStatefulWidget {
  final bool isMobile;
  const FiltersPane({super.key, required this.isMobile});

  @override
  ConsumerState<FiltersPane> createState() => _FiltersPaneState();
}

class _FiltersPaneState extends ConsumerState<FiltersPane> {
  // Доли высоты секций. Сумма = 1.
  double _r1 = 1 / 3, _r2 = 1 / 3, _r3 = 1 / 3;

  static const double _headerH = 28.0; // высота заголовка-сепаратора
  static const double _minSectionPx = 80.0;

  void _dragFirst(double deltaPx, double totalVar) {
    final min = _minSectionPx / totalVar;
    var r1 = _r1 + deltaPx / totalVar;
    var r2 = _r2 - deltaPx / totalVar;
    r1 = r1.clamp(min, 1 - _r3 - min);
    r2 = r2.clamp(min, 1 - _r3 - min);
    setState(() {
      _r1 = r1;
      _r2 = 1 - _r3 - _r1;
    });
  }

  void _dragSecond(double deltaPx, double totalVar) {
    final min = _minSectionPx / totalVar;
    var r2 = _r2 + deltaPx / totalVar;
    var r3 = _r3 - deltaPx / totalVar;
    r2 = r2.clamp(min, 1 - _r1 - min);
    r3 = r3.clamp(min, 1 - _r1 - min);
    setState(() {
      _r2 = r2;
      _r3 = 1 - _r1 - _r2;
    });
  }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(browserStateControllerProvider);
    return async.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            'Error: $e\nSelect source and scan.',
            textAlign: TextAlign.center,
          ),
        ),
      ),
      data: (s) {
        final dirs = s.allDirs.toList()..sort();
        final exts = s.allExts.toList()..sort();
        final files = s.filteredFiles;

        void extractAction() {
          if (s.selectedPaths.isEmpty) {
            ref
                .read(progressControllerProvider.notifier)
                .setLevel(StatusLevel.warn);
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Select files first')));
            return;
          }
          if (widget.isMobile) {
            context.go('/viewer', extra: s.selectedPaths);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Loading ${s.selectedPaths.length} files…'),
              ),
            );
          }
        }

        // Компактный заголовок (без перетаскивания).
        Widget header(String text) => SizedBox(
          height: _headerH,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(text, style: Theme.of(context).textTheme.titleSmall),
            ),
          ),
        );

        // Лейбл‑разделитель: невидимый, перетаскивается по вертикали.
        Widget headerDrag(String text, void Function(double dy) onDrag) =>
            SizedBox(
              height: _headerH,
              child: MouseRegion(
                cursor: SystemMouseCursors.resizeUpDown,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onVerticalDragUpdate: (d) => onDrag(d.delta.dy),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        text,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                  ),
                ),
              ),
            );

        return Column(
          children: [
            // Верхняя часть — три секции с «лейблами‑разделителями».
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Фикс: 3 строки‑заголовка.
                  final fixed = _headerH * 3;
                  final varTotal = (constraints.maxHeight - fixed)
                      .clamp(0.0, constraints.maxHeight)
                      .toDouble();
                  final h1 = varTotal * _r1;
                  final h2 = varTotal * _r2;
                  final h3 = varTotal * _r3;

                  return Column(
                    children: [
                      header(
                        'Excluded Dirs: ${s.excludedDirs.length} / ${dirs.length}',
                      ),
                      SizedBox(
                        height: h1,
                        child: Card(
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: DirsList(
                              dirs: dirs,
                              excluded: s.excludedDirs,
                              onToggle: (d) => ref
                                  .read(browserStateControllerProvider.notifier)
                                  .toggleExcludeDir(d),
                            ),
                          ),
                        ),
                      ),
                      headerDrag(
                        'Included Exts: ${s.includedExts.isEmpty ? "All" : s.includedExts.length.toString()} / ${exts.length}',
                        (dy) => _dragFirst(dy, varTotal),
                      ),
                      SizedBox(
                        height: h2,
                        child: Card(
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: ExtsList(
                              exts: exts,
                              included: s.includedExts,
                              onToggle: (e) => ref
                                  .read(browserStateControllerProvider.notifier)
                                  .toggleIncludeExt(e),
                            ),
                          ),
                        ),
                      ),
                      headerDrag(
                        'Selected Files: ${s.selectedPaths.length} / ${files.length}',
                        (dy) => _dragSecond(dy, varTotal),
                      ),
                      SizedBox(
                        height: h3,
                        child: Card(
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: FilesList(
                              files: files,
                              selected: s.selectedPaths,
                              indexMap: s.selectedIndexByPath,
                              onChange: (v) => ref
                                  .read(browserStateControllerProvider.notifier)
                                  .setSelectedPaths(v),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            // Низ — тулбар.
            Padding(
              padding: const EdgeInsets.all(12),
              child: SelectionToolbar(
                allSelected:
                    files.isNotEmpty && s.selectedPaths.length == files.length,
                onToggleSelectAll: () {
                  final allSelected =
                      files.isNotEmpty &&
                      s.selectedPaths.length == files.length;
                  if (allSelected) {
                    ref
                        .read(browserStateControllerProvider.notifier)
                        .setSelectedPaths(const []);
                  } else {
                    final paths = [for (final f in files) f.path];
                    ref
                        .read(browserStateControllerProvider.notifier)
                        .setSelectedPaths(paths);
                  }
                },
                onSave: () async {
                  final messenger = ScaffoldMessenger.of(context);
                  try {
                    await ref
                        .read(progressControllerProvider.notifier)
                        .run(
                          label: 'Saving selection',
                          task: (report) async {
                            report(30);
                            await ref
                                .read(selectionsControllerProvider.notifier)
                                .save(s);
                            report(100);
                          },
                        );
                    messenger.showSnackBar(
                      const SnackBar(content: Text('Selection saved')),
                    );
                  } catch (_) {
                    messenger.showSnackBar(
                      const SnackBar(content: Text('Save failed')),
                    );
                  }
                },
                onLoad: () async {
                  final messenger = ScaffoldMessenger.of(context);
                  try {
                    final model = await ref
                        .read(progressControllerProvider.notifier)
                        .run(
                          label: 'Loading selection',
                          task: (report) async {
                            final m = await ref
                                .read(selectionsControllerProvider.notifier)
                                .load();
                            report(100);
                            return m;
                          },
                        );
                    if (model == null) {
                      messenger.showSnackBar(
                        const SnackBar(content: Text('No saved selection')),
                      );
                      return;
                    }
                    final st = s.copyWith(
                      excludedDirs: model.directories.toSet(),
                      includedExts: model.extensions.toSet(),
                      selectedPaths: model.files,
                    );
                    ref
                        .read(browserStateControllerProvider.notifier)
                        .applyExternalState(st);
                    messenger.showSnackBar(
                      const SnackBar(content: Text('Selection loaded')),
                    );
                  } catch (_) {
                    messenger.showSnackBar(
                      const SnackBar(content: Text('Load failed')),
                    );
                  }
                },
                onExtract: extractAction,
                showExtract: widget.isMobile,
              ),
            ),
          ],
        );
      },
    );
  }
}
