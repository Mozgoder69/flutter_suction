import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../source_select/application/source_controller.dart';
import '../domain/selection_model.dart';
import '../infrastructure/selections_store.dart';
import '../../project_browser/domain/browser_state.dart';
part 'selections_controller.g.dart';

@riverpod
SelectionsStore selectionsStore(Ref ref) => SelectionsStore();

@riverpod
class SelectionsController extends _$SelectionsController {
  @override
  Future<void> build() async {}

  Future<void> save(BrowserState s) async {
    final spec = ref.read(sourceControllerProvider);
    if (spec == null) return;
    final store = ref.read(selectionsStoreProvider);
    final model = SelectionModel(
      project: spec.toString(),
      directories: s.excludedDirs.toList(),
      extensions: s.includedExts.toList(),
      files: s.selectedPaths,
    );
    await store.saveSelection(model);
  }

  Future<SelectionModel?> load() async {
    final spec = ref.read(sourceControllerProvider);
    if (spec == null) return null;
    final store = ref.read(selectionsStoreProvider);
    return store.loadSelection(spec.toString());
  }
}
