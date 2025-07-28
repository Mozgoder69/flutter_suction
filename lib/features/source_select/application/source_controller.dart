import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/utils/parse_source_spec.dart';
import '../domain/source_spec.dart';

part 'source_controller.g.dart';

@riverpod
class SourceController extends _$SourceController {
  @override
  SourceSpec? build() => null;

  void setInput(String input) {
    state = parseSourceSpec(input);
  }

  void clear() => state = null;
}
