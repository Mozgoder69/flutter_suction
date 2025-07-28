// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'source_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(SourceController)
const sourceControllerProvider = SourceControllerProvider._();

final class SourceControllerProvider
    extends $NotifierProvider<SourceController, SourceSpec?> {
  const SourceControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sourceControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sourceControllerHash();

  @$internal
  @override
  SourceController create() => SourceController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SourceSpec? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SourceSpec?>(value),
    );
  }
}

String _$sourceControllerHash() => r'abccef762cbd09fb299a075a81d7fbf1318a771d';

abstract class _$SourceController extends $Notifier<SourceSpec?> {
  SourceSpec? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<SourceSpec?, SourceSpec?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SourceSpec?, SourceSpec?>,
              SourceSpec?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
