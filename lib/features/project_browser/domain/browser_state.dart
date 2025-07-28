import 'package:freezed_annotation/freezed_annotation.dart';
import 'file_entry.dart';

part 'browser_state.freezed.dart';

@freezed
abstract class BrowserState with _$BrowserState {
  const factory BrowserState({
    @Default(<FileEntry>[]) List<FileEntry> allFiles,
    @Default(<String>{}) Set<String> allDirs,
    @Default(<String>{}) Set<String> allExts,
    @Default(<String>{}) Set<String> excludedDirs,
    @Default(<String>{}) Set<String> includedExts,
    @Default(<String>[]) List<String> selectedPaths,
    @Default(<FileEntry>[]) List<FileEntry> filteredFiles,
    @Default(<String, int>{}) Map<String, int> selectedIndexByPath,
  }) = _BrowserState;
}
