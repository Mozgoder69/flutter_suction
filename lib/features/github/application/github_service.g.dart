// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'github_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(githubSource)
const githubSourceProvider = GithubSourceProvider._();

final class GithubSourceProvider
    extends $FunctionalProvider<GitHubSource?, GitHubSource?, GitHubSource?>
    with $Provider<GitHubSource?> {
  const GithubSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'githubSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$githubSourceHash();

  @$internal
  @override
  $ProviderElement<GitHubSource?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GitHubSource? create(Ref ref) {
    return githubSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GitHubSource? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GitHubSource?>(value),
    );
  }
}

String _$githubSourceHash() => r'6fa939d4d7dffd84ff1c7f4d761c9e82a57b5447';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
