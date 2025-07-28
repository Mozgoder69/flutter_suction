// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FileEntry _$FileEntryFromJson(Map<String, dynamic> json) => _FileEntry(
  path: json['path'] as String,
  size: (json['size'] as num?)?.toInt(),
  ext: json['ext'] as String,
  parents: (json['parents'] as List<dynamic>).map((e) => e as String).toSet(),
);

Map<String, dynamic> _$FileEntryToJson(_FileEntry instance) =>
    <String, dynamic>{
      'path': instance.path,
      'size': instance.size,
      'ext': instance.ext,
      'parents': instance.parents.toList(),
    };
