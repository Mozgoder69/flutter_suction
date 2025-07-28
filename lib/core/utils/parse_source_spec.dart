import '../../features/source_select/domain/source_spec.dart';

SourceSpec parseSourceSpec(String input) {
  input = input.trim();
  if (input.startsWith('https://api.github.com/repos/')) {
    return SourceSpec.apiUrl(input);
  }
  if (!input.startsWith('http') && input.contains('/')) {
    final parts = input.split('#');
    final ownerRepo = parts[0];
    final branch = parts.length > 1 && parts[1].isNotEmpty ? parts[1] : 'main';
    final owner = ownerRepo.split('/').first;
    final repo = ownerRepo.split('/').last;
    return SourceSpec.github(owner: owner, repo: repo, branch: branch);
  }
  return SourceSpec.local(path: input);
}
