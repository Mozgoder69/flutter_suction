// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'viewer_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(loadContentResult)
const loadContentResultProvider = LoadContentResultFamily._();

final class LoadContentResultProvider
    extends
        $FunctionalProvider<
          AsyncValue<LoadResult>,
          LoadResult,
          FutureOr<LoadResult>
        >
    with $FutureModifier<LoadResult>, $FutureProvider<LoadResult> {
  const LoadContentResultProvider._({
    required LoadContentResultFamily super.from,
    required List<String> super.argument,
  }) : super(
         retry: null,
         name: r'loadContentResultProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$loadContentResultHash();

  @override
  String toString() {
    return r'loadContentResultProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<LoadResult> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<LoadResult> create(Ref ref) {
    final argument = this.argument as List<String>;
    return loadContentResult(ref, paths: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is LoadContentResultProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$loadContentResultHash() => r'2efde530cfdb5dd76cd47055ab1dc16c3961cebd';

final class LoadContentResultFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<LoadResult>, List<String>> {
  const LoadContentResultFamily._()
    : super(
        retry: null,
        name: r'loadContentResultProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  LoadContentResultProvider call({required List<String> paths}) =>
      LoadContentResultProvider._(argument: paths, from: this);

  @override
  String toString() => r'loadContentResultProvider';
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
