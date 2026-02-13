// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'products_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProductsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProductsState()';
}


}

/// @nodoc
class $ProductsStateCopyWith<$Res>  {
$ProductsStateCopyWith(ProductsState _, $Res Function(ProductsState) __);
}


/// Adds pattern-matching-related methods to [ProductsState].
extension ProductsStatePatterns on ProductsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Loaded value)?  loaded,TResult Function( _Syncing value)?  syncing,TResult Function( _Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Syncing() when syncing != null:
return syncing(_that);case _Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Loaded value)  loaded,required TResult Function( _Syncing value)  syncing,required TResult Function( _Error value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Loaded():
return loaded(_that);case _Syncing():
return syncing(_that);case _Error():
return error(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Loaded value)?  loaded,TResult? Function( _Syncing value)?  syncing,TResult? Function( _Error value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Syncing() when syncing != null:
return syncing(_that);case _Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<Product> products,  bool isOffline,  bool isFromCache)?  loaded,TResult Function( List<Product> currentProducts)?  syncing,TResult Function( String message,  bool isOffline)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.products,_that.isOffline,_that.isFromCache);case _Syncing() when syncing != null:
return syncing(_that.currentProducts);case _Error() when error != null:
return error(_that.message,_that.isOffline);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<Product> products,  bool isOffline,  bool isFromCache)  loaded,required TResult Function( List<Product> currentProducts)  syncing,required TResult Function( String message,  bool isOffline)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Loaded():
return loaded(_that.products,_that.isOffline,_that.isFromCache);case _Syncing():
return syncing(_that.currentProducts);case _Error():
return error(_that.message,_that.isOffline);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<Product> products,  bool isOffline,  bool isFromCache)?  loaded,TResult? Function( List<Product> currentProducts)?  syncing,TResult? Function( String message,  bool isOffline)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.products,_that.isOffline,_that.isFromCache);case _Syncing() when syncing != null:
return syncing(_that.currentProducts);case _Error() when error != null:
return error(_that.message,_that.isOffline);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements ProductsState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProductsState.initial()';
}


}




/// @nodoc


class _Loading implements ProductsState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProductsState.loading()';
}


}




/// @nodoc


class _Loaded implements ProductsState {
  const _Loaded({required final  List<Product> products, required this.isOffline, required this.isFromCache}): _products = products;
  

 final  List<Product> _products;
 List<Product> get products {
  if (_products is EqualUnmodifiableListView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_products);
}

 final  bool isOffline;
 final  bool isFromCache;

/// Create a copy of ProductsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&const DeepCollectionEquality().equals(other._products, _products)&&(identical(other.isOffline, isOffline) || other.isOffline == isOffline)&&(identical(other.isFromCache, isFromCache) || other.isFromCache == isFromCache));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_products),isOffline,isFromCache);

@override
String toString() {
  return 'ProductsState.loaded(products: $products, isOffline: $isOffline, isFromCache: $isFromCache)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $ProductsStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@useResult
$Res call({
 List<Product> products, bool isOffline, bool isFromCache
});




}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of ProductsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? products = null,Object? isOffline = null,Object? isFromCache = null,}) {
  return _then(_Loaded(
products: null == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as List<Product>,isOffline: null == isOffline ? _self.isOffline : isOffline // ignore: cast_nullable_to_non_nullable
as bool,isFromCache: null == isFromCache ? _self.isFromCache : isFromCache // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _Syncing implements ProductsState {
  const _Syncing({required final  List<Product> currentProducts}): _currentProducts = currentProducts;
  

 final  List<Product> _currentProducts;
 List<Product> get currentProducts {
  if (_currentProducts is EqualUnmodifiableListView) return _currentProducts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_currentProducts);
}


/// Create a copy of ProductsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SyncingCopyWith<_Syncing> get copyWith => __$SyncingCopyWithImpl<_Syncing>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Syncing&&const DeepCollectionEquality().equals(other._currentProducts, _currentProducts));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_currentProducts));

@override
String toString() {
  return 'ProductsState.syncing(currentProducts: $currentProducts)';
}


}

/// @nodoc
abstract mixin class _$SyncingCopyWith<$Res> implements $ProductsStateCopyWith<$Res> {
  factory _$SyncingCopyWith(_Syncing value, $Res Function(_Syncing) _then) = __$SyncingCopyWithImpl;
@useResult
$Res call({
 List<Product> currentProducts
});




}
/// @nodoc
class __$SyncingCopyWithImpl<$Res>
    implements _$SyncingCopyWith<$Res> {
  __$SyncingCopyWithImpl(this._self, this._then);

  final _Syncing _self;
  final $Res Function(_Syncing) _then;

/// Create a copy of ProductsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? currentProducts = null,}) {
  return _then(_Syncing(
currentProducts: null == currentProducts ? _self._currentProducts : currentProducts // ignore: cast_nullable_to_non_nullable
as List<Product>,
  ));
}


}

/// @nodoc


class _Error implements ProductsState {
  const _Error({required this.message, required this.isOffline});
  

 final  String message;
 final  bool isOffline;

/// Create a copy of ProductsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.message, message) || other.message == message)&&(identical(other.isOffline, isOffline) || other.isOffline == isOffline));
}


@override
int get hashCode => Object.hash(runtimeType,message,isOffline);

@override
String toString() {
  return 'ProductsState.error(message: $message, isOffline: $isOffline)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $ProductsStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 String message, bool isOffline
});




}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of ProductsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,Object? isOffline = null,}) {
  return _then(_Error(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,isOffline: null == isOffline ? _self.isOffline : isOffline // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
