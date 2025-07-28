// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'file_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FileEntry {

 String get path;// относительный путь (posix)
 int? get size; String get ext;// с точкой: ".dart" | "" если нет
 Set<String> get parents;
/// Create a copy of FileEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FileEntryCopyWith<FileEntry> get copyWith => _$FileEntryCopyWithImpl<FileEntry>(this as FileEntry, _$identity);

  /// Serializes this FileEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FileEntry&&(identical(other.path, path) || other.path == path)&&(identical(other.size, size) || other.size == size)&&(identical(other.ext, ext) || other.ext == ext)&&const DeepCollectionEquality().equals(other.parents, parents));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,path,size,ext,const DeepCollectionEquality().hash(parents));

@override
String toString() {
  return 'FileEntry(path: $path, size: $size, ext: $ext, parents: $parents)';
}


}

/// @nodoc
abstract mixin class $FileEntryCopyWith<$Res>  {
  factory $FileEntryCopyWith(FileEntry value, $Res Function(FileEntry) _then) = _$FileEntryCopyWithImpl;
@useResult
$Res call({
 String path, int? size, String ext, Set<String> parents
});




}
/// @nodoc
class _$FileEntryCopyWithImpl<$Res>
    implements $FileEntryCopyWith<$Res> {
  _$FileEntryCopyWithImpl(this._self, this._then);

  final FileEntry _self;
  final $Res Function(FileEntry) _then;

/// Create a copy of FileEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? path = null,Object? size = freezed,Object? ext = null,Object? parents = null,}) {
  return _then(_self.copyWith(
path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,size: freezed == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int?,ext: null == ext ? _self.ext : ext // ignore: cast_nullable_to_non_nullable
as String,parents: null == parents ? _self.parents : parents // ignore: cast_nullable_to_non_nullable
as Set<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [FileEntry].
extension FileEntryPatterns on FileEntry {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FileEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FileEntry() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FileEntry value)  $default,){
final _that = this;
switch (_that) {
case _FileEntry():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FileEntry value)?  $default,){
final _that = this;
switch (_that) {
case _FileEntry() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String path,  int? size,  String ext,  Set<String> parents)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FileEntry() when $default != null:
return $default(_that.path,_that.size,_that.ext,_that.parents);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String path,  int? size,  String ext,  Set<String> parents)  $default,) {final _that = this;
switch (_that) {
case _FileEntry():
return $default(_that.path,_that.size,_that.ext,_that.parents);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String path,  int? size,  String ext,  Set<String> parents)?  $default,) {final _that = this;
switch (_that) {
case _FileEntry() when $default != null:
return $default(_that.path,_that.size,_that.ext,_that.parents);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FileEntry implements FileEntry {
  const _FileEntry({required this.path, this.size, required this.ext, required final  Set<String> parents}): _parents = parents;
  factory _FileEntry.fromJson(Map<String, dynamic> json) => _$FileEntryFromJson(json);

@override final  String path;
// относительный путь (posix)
@override final  int? size;
@override final  String ext;
// с точкой: ".dart" | "" если нет
 final  Set<String> _parents;
// с точкой: ".dart" | "" если нет
@override Set<String> get parents {
  if (_parents is EqualUnmodifiableSetView) return _parents;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_parents);
}


/// Create a copy of FileEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FileEntryCopyWith<_FileEntry> get copyWith => __$FileEntryCopyWithImpl<_FileEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FileEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FileEntry&&(identical(other.path, path) || other.path == path)&&(identical(other.size, size) || other.size == size)&&(identical(other.ext, ext) || other.ext == ext)&&const DeepCollectionEquality().equals(other._parents, _parents));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,path,size,ext,const DeepCollectionEquality().hash(_parents));

@override
String toString() {
  return 'FileEntry(path: $path, size: $size, ext: $ext, parents: $parents)';
}


}

/// @nodoc
abstract mixin class _$FileEntryCopyWith<$Res> implements $FileEntryCopyWith<$Res> {
  factory _$FileEntryCopyWith(_FileEntry value, $Res Function(_FileEntry) _then) = __$FileEntryCopyWithImpl;
@override @useResult
$Res call({
 String path, int? size, String ext, Set<String> parents
});




}
/// @nodoc
class __$FileEntryCopyWithImpl<$Res>
    implements _$FileEntryCopyWith<$Res> {
  __$FileEntryCopyWithImpl(this._self, this._then);

  final _FileEntry _self;
  final $Res Function(_FileEntry) _then;

/// Create a copy of FileEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? path = null,Object? size = freezed,Object? ext = null,Object? parents = null,}) {
  return _then(_FileEntry(
path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,size: freezed == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int?,ext: null == ext ? _self.ext : ext // ignore: cast_nullable_to_non_nullable
as String,parents: null == parents ? _self._parents : parents // ignore: cast_nullable_to_non_nullable
as Set<String>,
  ));
}


}

// dart format on
