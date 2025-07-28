// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(localSource)
const localSourceProvider = LocalSourceProvider._();

final class LocalSourceProvider
    extends $FunctionalProvider<LocalSource?, LocalSource?, LocalSource?>
    with $Provider<LocalSource?> {
  const LocalSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localSourceHash();

  @$internal
  @override
  $ProviderElement<LocalSource?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LocalSource? create(Ref ref) {
    return localSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocalSource? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocalSource?>(value),
    );
  }
}

String _$localSourceHash() => r'5cc218e3697088f5c393e21e3f3137d9654a5047';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
