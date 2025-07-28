import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../source_select/application/source_controller.dart';
import '../infrastructure/local_source.dart';

part 'local_service.g.dart';

@riverpod
LocalSource? localSource(Ref ref) {
  final spec = ref.watch(sourceControllerProvider);
  if (spec == null || spec.kind != 'local') return null;
  return LocalSource(spec.path!);
}
