import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/progress_state.dart';

part 'progress_controller.g.dart';

@riverpod
class ProgressController extends _$ProgressController {
  @override
  ProgressState build() => const ProgressState();

  void reset([String msg = 'Ready']) {
    state = ProgressState(message: msg, value: 0, level: StatusLevel.pass);
  }

  void setMessage(String msg) {
    state = state.copyWith(message: msg);
  }

  void setValue(int v) {
    final vv = v.clamp(0, 100);
    state = state.copyWith(value: vv);
  }

  void setLevel(StatusLevel lvl) {
    state = state.copyWith(level: lvl);
  }

  /// Удобный helper для длительных операций
  Future<T> run<T>({
    required String label,
    required Future<T> Function(void Function(int v) report) task,
  }) async {
    setMessage(label);
    setLevel(StatusLevel.info);
    setValue(0);
    try {
      final result = await task(setValue);
      setMessage('$label - Complete');
      setLevel(StatusLevel.pass);
      setValue(100);
      return result;
    } catch (e) {
      setMessage('$label - Error');
      setLevel(StatusLevel.fail);
      rethrow;
    }
  }
}
