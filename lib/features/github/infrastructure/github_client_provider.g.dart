// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'github_client_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(githubClientAsync)
const githubClientAsyncProvider = GithubClientAsyncProvider._();

final class GithubClientAsyncProvider
    extends
        $FunctionalProvider<
          AsyncValue<GithubClient>,
          GithubClient,
          FutureOr<GithubClient>
        >
    with $FutureModifier<GithubClient>, $FutureProvider<GithubClient> {
  const GithubClientAsyncProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'githubClientAsyncProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$githubClientAsyncHash();

  @$internal
  @override
  $FutureProviderElement<GithubClient> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<GithubClient> create(Ref ref) {
    return githubClientAsync(ref);
  }
}

String _$githubClientAsyncHash() => r'f143d52965d099c9343c187ae3507d690a1bf467';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
