// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'browser_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(BrowserController)
const browserControllerProvider = BrowserControllerProvider._();

final class BrowserControllerProvider
    extends $AsyncNotifierProvider<BrowserController, Result<TreeResponse>> {
  const BrowserControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'browserControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$browserControllerHash();

  @$internal
  @override
  BrowserController create() => BrowserController();
}

String _$browserControllerHash() => r'137739a2066722c55ea615ed3846af58d7a8fa95';

abstract class _$BrowserController
    extends $AsyncNotifier<Result<TreeResponse>> {
  FutureOr<Result<TreeResponse>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<AsyncValue<Result<TreeResponse>>, Result<TreeResponse>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<Result<TreeResponse>>,
                Result<TreeResponse>
              >,
              AsyncValue<Result<TreeResponse>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
