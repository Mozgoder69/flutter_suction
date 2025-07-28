// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selections_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(selectionsStore)
const selectionsStoreProvider = SelectionsStoreProvider._();

final class SelectionsStoreProvider
    extends
        $FunctionalProvider<SelectionsStore, SelectionsStore, SelectionsStore>
    with $Provider<SelectionsStore> {
  const SelectionsStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectionsStoreProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectionsStoreHash();

  @$internal
  @override
  $ProviderElement<SelectionsStore> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SelectionsStore create(Ref ref) {
    return selectionsStore(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SelectionsStore value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SelectionsStore>(value),
    );
  }
}

String _$selectionsStoreHash() => r'957e5fd0983c6f8e451e488c91c264e23edc050f';

@ProviderFor(SelectionsController)
const selectionsControllerProvider = SelectionsControllerProvider._();

final class SelectionsControllerProvider
    extends $AsyncNotifierProvider<SelectionsController, void> {
  const SelectionsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectionsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectionsControllerHash();

  @$internal
  @override
  SelectionsController create() => SelectionsController();
}

String _$selectionsControllerHash() =>
    r'297564a762dc7db9cbf824748a68fa36a4542f5a';

abstract class _$SelectionsController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleValue(ref, null);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
