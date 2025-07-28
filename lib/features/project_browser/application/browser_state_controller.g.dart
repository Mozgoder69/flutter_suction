// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'browser_state_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(BrowserStateController)
const browserStateControllerProvider = BrowserStateControllerProvider._();

final class BrowserStateControllerProvider
    extends $AsyncNotifierProvider<BrowserStateController, BrowserState> {
  const BrowserStateControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'browserStateControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$browserStateControllerHash();

  @$internal
  @override
  BrowserStateController create() => BrowserStateController();
}

String _$browserStateControllerHash() =>
    r'b49fb32fced6abe0a7c42983a4b29f6c79960f82';

abstract class _$BrowserStateController extends $AsyncNotifier<BrowserState> {
  FutureOr<BrowserState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<BrowserState>, BrowserState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<BrowserState>, BrowserState>,
              AsyncValue<BrowserState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
