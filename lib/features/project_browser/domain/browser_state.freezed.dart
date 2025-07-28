// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'browser_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BrowserState {

 List<FileEntry> get allFiles; Set<String> get allDirs; Set<String> get allExts; Set<String> get excludedDirs; Set<String> get includedExts; List<String> get selectedPaths; List<FileEntry> get filteredFiles; Map<String, int> get selectedIndexByPath;
/// Create a copy of BrowserState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BrowserStateCopyWith<BrowserState> get copyWith => _$BrowserStateCopyWithImpl<BrowserState>(this as BrowserState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BrowserState&&const DeepCollectionEquality().equals(other.allFiles, allFiles)&&const DeepCollectionEquality().equals(other.allDirs, allDirs)&&const DeepCollectionEquality().equals(other.allExts, allExts)&&const DeepCollectionEquality().equals(other.excludedDirs, excludedDirs)&&const DeepCollectionEquality().equals(other.includedExts, includedExts)&&const DeepCollectionEquality().equals(other.selectedPaths, selectedPaths)&&const DeepCollectionEquality().equals(other.filteredFiles, filteredFiles)&&const DeepCollectionEquality().equals(other.selectedIndexByPath, selectedIndexByPath));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(allFiles),const DeepCollectionEquality().hash(allDirs),const DeepCollectionEquality().hash(allExts),const DeepCollectionEquality().hash(excludedDirs),const DeepCollectionEquality().hash(includedExts),const DeepCollectionEquality().hash(selectedPaths),const DeepCollectionEquality().hash(filteredFiles),const DeepCollectionEquality().hash(selectedIndexByPath));

@override
String toString() {
  return 'BrowserState(allFiles: $allFiles, allDirs: $allDirs, allExts: $allExts, excludedDirs: $excludedDirs, includedExts: $includedExts, selectedPaths: $selectedPaths, filteredFiles: $filteredFiles, selectedIndexByPath: $selectedIndexByPath)';
}


}

/// @nodoc
abstract mixin class $BrowserStateCopyWith<$Res>  {
  factory $BrowserStateCopyWith(BrowserState value, $Res Function(BrowserState) _then) = _$BrowserStateCopyWithImpl;
@useResult
$Res call({
 List<FileEntry> allFiles, Set<String> allDirs, Set<String> allExts, Set<String> excludedDirs, Set<String> includedExts, List<String> selectedPaths, List<FileEntry> filteredFiles, Map<String, int> selectedIndexByPath
});




}
/// @nodoc
class _$BrowserStateCopyWithImpl<$Res>
    implements $BrowserStateCopyWith<$Res> {
  _$BrowserStateCopyWithImpl(this._self, this._then);

  final BrowserState _self;
  final $Res Function(BrowserState) _then;

/// Create a copy of BrowserState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? allFiles = null,Object? allDirs = null,Object? allExts = null,Object? excludedDirs = null,Object? includedExts = null,Object? selectedPaths = null,Object? filteredFiles = null,Object? selectedIndexByPath = null,}) {
  return _then(_self.copyWith(
allFiles: null == allFiles ? _self.allFiles : allFiles // ignore: cast_nullable_to_non_nullable
as List<FileEntry>,allDirs: null == allDirs ? _self.allDirs : allDirs // ignore: cast_nullable_to_non_nullable
as Set<String>,allExts: null == allExts ? _self.allExts : allExts // ignore: cast_nullable_to_non_nullable
as Set<String>,excludedDirs: null == excludedDirs ? _self.excludedDirs : excludedDirs // ignore: cast_nullable_to_non_nullable
as Set<String>,includedExts: null == includedExts ? _self.includedExts : includedExts // ignore: cast_nullable_to_non_nullable
as Set<String>,selectedPaths: null == selectedPaths ? _self.selectedPaths : selectedPaths // ignore: cast_nullable_to_non_nullable
as List<String>,filteredFiles: null == filteredFiles ? _self.filteredFiles : filteredFiles // ignore: cast_nullable_to_non_nullable
as List<FileEntry>,selectedIndexByPath: null == selectedIndexByPath ? _self.selectedIndexByPath : selectedIndexByPath // ignore: cast_nullable_to_non_nullable
as Map<String, int>,
  ));
}

}


/// Adds pattern-matching-related methods to [BrowserState].
extension BrowserStatePatterns on BrowserState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BrowserState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BrowserState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BrowserState value)  $default,){
final _that = this;
switch (_that) {
case _BrowserState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BrowserState value)?  $default,){
final _that = this;
switch (_that) {
case _BrowserState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<FileEntry> allFiles,  Set<String> allDirs,  Set<String> allExts,  Set<String> excludedDirs,  Set<String> includedExts,  List<String> selectedPaths,  List<FileEntry> filteredFiles,  Map<String, int> selectedIndexByPath)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BrowserState() when $default != null:
return $default(_that.allFiles,_that.allDirs,_that.allExts,_that.excludedDirs,_that.includedExts,_that.selectedPaths,_that.filteredFiles,_that.selectedIndexByPath);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<FileEntry> allFiles,  Set<String> allDirs,  Set<String> allExts,  Set<String> excludedDirs,  Set<String> includedExts,  List<String> selectedPaths,  List<FileEntry> filteredFiles,  Map<String, int> selectedIndexByPath)  $default,) {final _that = this;
switch (_that) {
case _BrowserState():
return $default(_that.allFiles,_that.allDirs,_that.allExts,_that.excludedDirs,_that.includedExts,_that.selectedPaths,_that.filteredFiles,_that.selectedIndexByPath);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<FileEntry> allFiles,  Set<String> allDirs,  Set<String> allExts,  Set<String> excludedDirs,  Set<String> includedExts,  List<String> selectedPaths,  List<FileEntry> filteredFiles,  Map<String, int> selectedIndexByPath)?  $default,) {final _that = this;
switch (_that) {
case _BrowserState() when $default != null:
return $default(_that.allFiles,_that.allDirs,_that.allExts,_that.excludedDirs,_that.includedExts,_that.selectedPaths,_that.filteredFiles,_that.selectedIndexByPath);case _:
  return null;

}
}

}

/// @nodoc


class _BrowserState implements BrowserState {
  const _BrowserState({final  List<FileEntry> allFiles = const <FileEntry>[], final  Set<String> allDirs = const <String>{}, final  Set<String> allExts = const <String>{}, final  Set<String> excludedDirs = const <String>{}, final  Set<String> includedExts = const <String>{}, final  List<String> selectedPaths = const <String>[], final  List<FileEntry> filteredFiles = const <FileEntry>[], final  Map<String, int> selectedIndexByPath = const <String, int>{}}): _allFiles = allFiles,_allDirs = allDirs,_allExts = allExts,_excludedDirs = excludedDirs,_includedExts = includedExts,_selectedPaths = selectedPaths,_filteredFiles = filteredFiles,_selectedIndexByPath = selectedIndexByPath;
  

 final  List<FileEntry> _allFiles;
@override@JsonKey() List<FileEntry> get allFiles {
  if (_allFiles is EqualUnmodifiableListView) return _allFiles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_allFiles);
}

 final  Set<String> _allDirs;
@override@JsonKey() Set<String> get allDirs {
  if (_allDirs is EqualUnmodifiableSetView) return _allDirs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_allDirs);
}

 final  Set<String> _allExts;
@override@JsonKey() Set<String> get allExts {
  if (_allExts is EqualUnmodifiableSetView) return _allExts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_allExts);
}

 final  Set<String> _excludedDirs;
@override@JsonKey() Set<String> get excludedDirs {
  if (_excludedDirs is EqualUnmodifiableSetView) return _excludedDirs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_excludedDirs);
}

 final  Set<String> _includedExts;
@override@JsonKey() Set<String> get includedExts {
  if (_includedExts is EqualUnmodifiableSetView) return _includedExts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_includedExts);
}

 final  List<String> _selectedPaths;
@override@JsonKey() List<String> get selectedPaths {
  if (_selectedPaths is EqualUnmodifiableListView) return _selectedPaths;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedPaths);
}

 final  List<FileEntry> _filteredFiles;
@override@JsonKey() List<FileEntry> get filteredFiles {
  if (_filteredFiles is EqualUnmodifiableListView) return _filteredFiles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_filteredFiles);
}

 final  Map<String, int> _selectedIndexByPath;
@override@JsonKey() Map<String, int> get selectedIndexByPath {
  if (_selectedIndexByPath is EqualUnmodifiableMapView) return _selectedIndexByPath;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_selectedIndexByPath);
}


/// Create a copy of BrowserState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BrowserStateCopyWith<_BrowserState> get copyWith => __$BrowserStateCopyWithImpl<_BrowserState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BrowserState&&const DeepCollectionEquality().equals(other._allFiles, _allFiles)&&const DeepCollectionEquality().equals(other._allDirs, _allDirs)&&const DeepCollectionEquality().equals(other._allExts, _allExts)&&const DeepCollectionEquality().equals(other._excludedDirs, _excludedDirs)&&const DeepCollectionEquality().equals(other._includedExts, _includedExts)&&const DeepCollectionEquality().equals(other._selectedPaths, _selectedPaths)&&const DeepCollectionEquality().equals(other._filteredFiles, _filteredFiles)&&const DeepCollectionEquality().equals(other._selectedIndexByPath, _selectedIndexByPath));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_allFiles),const DeepCollectionEquality().hash(_allDirs),const DeepCollectionEquality().hash(_allExts),const DeepCollectionEquality().hash(_excludedDirs),const DeepCollectionEquality().hash(_includedExts),const DeepCollectionEquality().hash(_selectedPaths),const DeepCollectionEquality().hash(_filteredFiles),const DeepCollectionEquality().hash(_selectedIndexByPath));

@override
String toString() {
  return 'BrowserState(allFiles: $allFiles, allDirs: $allDirs, allExts: $allExts, excludedDirs: $excludedDirs, includedExts: $includedExts, selectedPaths: $selectedPaths, filteredFiles: $filteredFiles, selectedIndexByPath: $selectedIndexByPath)';
}


}

/// @nodoc
abstract mixin class _$BrowserStateCopyWith<$Res> implements $BrowserStateCopyWith<$Res> {
  factory _$BrowserStateCopyWith(_BrowserState value, $Res Function(_BrowserState) _then) = __$BrowserStateCopyWithImpl;
@override @useResult
$Res call({
 List<FileEntry> allFiles, Set<String> allDirs, Set<String> allExts, Set<String> excludedDirs, Set<String> includedExts, List<String> selectedPaths, List<FileEntry> filteredFiles, Map<String, int> selectedIndexByPath
});




}
/// @nodoc
class __$BrowserStateCopyWithImpl<$Res>
    implements _$BrowserStateCopyWith<$Res> {
  __$BrowserStateCopyWithImpl(this._self, this._then);

  final _BrowserState _self;
  final $Res Function(_BrowserState) _then;

/// Create a copy of BrowserState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? allFiles = null,Object? allDirs = null,Object? allExts = null,Object? excludedDirs = null,Object? includedExts = null,Object? selectedPaths = null,Object? filteredFiles = null,Object? selectedIndexByPath = null,}) {
  return _then(_BrowserState(
allFiles: null == allFiles ? _self._allFiles : allFiles // ignore: cast_nullable_to_non_nullable
as List<FileEntry>,allDirs: null == allDirs ? _self._allDirs : allDirs // ignore: cast_nullable_to_non_nullable
as Set<String>,allExts: null == allExts ? _self._allExts : allExts // ignore: cast_nullable_to_non_nullable
as Set<String>,excludedDirs: null == excludedDirs ? _self._excludedDirs : excludedDirs // ignore: cast_nullable_to_non_nullable
as Set<String>,includedExts: null == includedExts ? _self._includedExts : includedExts // ignore: cast_nullable_to_non_nullable
as Set<String>,selectedPaths: null == selectedPaths ? _self._selectedPaths : selectedPaths // ignore: cast_nullable_to_non_nullable
as List<String>,filteredFiles: null == filteredFiles ? _self._filteredFiles : filteredFiles // ignore: cast_nullable_to_non_nullable
as List<FileEntry>,selectedIndexByPath: null == selectedIndexByPath ? _self._selectedIndexByPath : selectedIndexByPath // ignore: cast_nullable_to_non_nullable
as Map<String, int>,
  ));
}


}

// dart format on
