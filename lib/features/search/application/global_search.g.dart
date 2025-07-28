// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'global_search.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(globalSearch)
const globalSearchProvider = GlobalSearchFamily._();

final class GlobalSearchProvider
    extends
        $FunctionalProvider<
          AsyncValue<GlobalSearchResult>,
          GlobalSearchResult,
          FutureOr<GlobalSearchResult>
        >
    with
        $FutureModifier<GlobalSearchResult>,
        $FutureProvider<GlobalSearchResult> {
  const GlobalSearchProvider._({
    required GlobalSearchFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'globalSearchProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$globalSearchHash();

  @override
  String toString() {
    return r'globalSearchProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<GlobalSearchResult> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<GlobalSearchResult> create(Ref ref) {
    final argument = this.argument as String;
    return globalSearch(ref, query: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is GlobalSearchProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$globalSearchHash() => r'5867d3141672c89f40703f6d1497905d33630c14';

final class GlobalSearchFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<GlobalSearchResult>, String> {
  const GlobalSearchFamily._()
    : super(
        retry: null,
        name: r'globalSearchProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GlobalSearchProvider call({required String query}) =>
      GlobalSearchProvider._(argument: query, from: this);

  @override
  String toString() => r'globalSearchProvider';
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
