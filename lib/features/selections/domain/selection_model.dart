class SelectionModel {
  final String project; // строка источника (owner/repo#branch)
  final List<String> directories;
  final List<String> extensions;
  final List<String> files;

  const SelectionModel({
    required this.project,
    required this.directories,
    required this.extensions,
    required this.files,
  });

  Map<String, dynamic> toJson() => {
    'project_path': project,
    'directories': directories,
    'extensions': extensions,
    'files': files,
  };

  factory SelectionModel.fromJson(Map<String, dynamic> json) => SelectionModel(
    project: json['project_path'] as String,
    directories: (json['directories'] as List<dynamic>).cast<String>(),
    extensions: (json['extensions'] as List<dynamic>).cast<String>(),
    files: (json['files'] as List<dynamic>).cast<String>(),
  );
}
