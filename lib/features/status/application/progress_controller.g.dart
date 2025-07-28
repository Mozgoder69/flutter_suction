// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(ProgressController)
const progressControllerProvider = ProgressControllerProvider._();

final class ProgressControllerProvider
    extends $NotifierProvider<ProgressController, ProgressState> {
  const ProgressControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'progressControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$progressControllerHash();

  @$internal
  @override
  ProgressController create() => ProgressController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProgressState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProgressState>(value),
    );
  }
}

String _$progressControllerHash() =>
    r'0edf72760690c7d9ba302fb840e4acb840e15172';

abstract class _$ProgressController extends $Notifier<ProgressState> {
  ProgressState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ProgressState, ProgressState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ProgressState, ProgressState>,
              ProgressState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
