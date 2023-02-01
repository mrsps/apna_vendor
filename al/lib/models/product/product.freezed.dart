// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Product _$ProductFromJson(Map<String, dynamic> json) {
  return _Product.fromJson(json);
}

/// @nodoc
class _$ProductTearOff {
  const _$ProductTearOff();

  _Product call(
      {String? userId,
      String? productId,
      String? categoryId,
      String? productName,
      Measure? productMeasure,
      int? productMinimumQuantity,
      double? productPrice}) {
    return _Product(
      userId: userId,
      productId: productId,
      categoryId: categoryId,
      productName: productName,
      productMeasure: productMeasure,
      productMinimumQuantity: productMinimumQuantity,
      productPrice: productPrice,
    );
  }

  Product fromJson(Map<String, Object> json) {
    return Product.fromJson(json);
  }
}

/// @nodoc
const $Product = _$ProductTearOff();

/// @nodoc
mixin _$Product {
  String? get userId => throw _privateConstructorUsedError;
  String? get productId => throw _privateConstructorUsedError;
  String? get categoryId => throw _privateConstructorUsedError;
  String? get productName => throw _privateConstructorUsedError;
  Measure? get productMeasure => throw _privateConstructorUsedError;
  int? get productMinimumQuantity => throw _privateConstructorUsedError;
  double? get productPrice => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductCopyWith<Product> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductCopyWith<$Res> {
  factory $ProductCopyWith(Product value, $Res Function(Product) then) =
      _$ProductCopyWithImpl<$Res>;
  $Res call(
      {String? userId,
      String? productId,
      String? categoryId,
      String? productName,
      Measure? productMeasure,
      int? productMinimumQuantity,
      double? productPrice});
}

/// @nodoc
class _$ProductCopyWithImpl<$Res> implements $ProductCopyWith<$Res> {
  _$ProductCopyWithImpl(this._value, this._then);

  final Product _value;
  // ignore: unused_field
  final $Res Function(Product) _then;

  @override
  $Res call({
    Object? userId = freezed,
    Object? productId = freezed,
    Object? categoryId = freezed,
    Object? productName = freezed,
    Object? productMeasure = freezed,
    Object? productMinimumQuantity = freezed,
    Object? productPrice = freezed,
  }) {
    return _then(_value.copyWith(
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      productId: productId == freezed
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryId: categoryId == freezed
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String?,
      productName: productName == freezed
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String?,
      productMeasure: productMeasure == freezed
          ? _value.productMeasure
          : productMeasure // ignore: cast_nullable_to_non_nullable
              as Measure?,
      productMinimumQuantity: productMinimumQuantity == freezed
          ? _value.productMinimumQuantity
          : productMinimumQuantity // ignore: cast_nullable_to_non_nullable
              as int?,
      productPrice: productPrice == freezed
          ? _value.productPrice
          : productPrice // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
abstract class _$ProductCopyWith<$Res> implements $ProductCopyWith<$Res> {
  factory _$ProductCopyWith(_Product value, $Res Function(_Product) then) =
      __$ProductCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? userId,
      String? productId,
      String? categoryId,
      String? productName,
      Measure? productMeasure,
      int? productMinimumQuantity,
      double? productPrice});
}

/// @nodoc
class __$ProductCopyWithImpl<$Res> extends _$ProductCopyWithImpl<$Res>
    implements _$ProductCopyWith<$Res> {
  __$ProductCopyWithImpl(_Product _value, $Res Function(_Product) _then)
      : super(_value, (v) => _then(v as _Product));

  @override
  _Product get _value => super._value as _Product;

  @override
  $Res call({
    Object? userId = freezed,
    Object? productId = freezed,
    Object? categoryId = freezed,
    Object? productName = freezed,
    Object? productMeasure = freezed,
    Object? productMinimumQuantity = freezed,
    Object? productPrice = freezed,
  }) {
    return _then(_Product(
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      productId: productId == freezed
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryId: categoryId == freezed
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String?,
      productName: productName == freezed
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String?,
      productMeasure: productMeasure == freezed
          ? _value.productMeasure
          : productMeasure // ignore: cast_nullable_to_non_nullable
              as Measure?,
      productMinimumQuantity: productMinimumQuantity == freezed
          ? _value.productMinimumQuantity
          : productMinimumQuantity // ignore: cast_nullable_to_non_nullable
              as int?,
      productPrice: productPrice == freezed
          ? _value.productPrice
          : productPrice // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Product implements _Product {
  const _$_Product(
      {this.userId,
      this.productId,
      this.categoryId,
      this.productName,
      this.productMeasure,
      this.productMinimumQuantity,
      this.productPrice});

  factory _$_Product.fromJson(Map<String, dynamic> json) =>
      _$_$_ProductFromJson(json);

  @override
  final String? userId;
  @override
  final String? productId;
  @override
  final String? categoryId;
  @override
  final String? productName;
  @override
  final Measure? productMeasure;
  @override
  final int? productMinimumQuantity;
  @override
  final double? productPrice;

  @override
  String toString() {
    return 'Product(userId: $userId, productId: $productId, categoryId: $categoryId, productName: $productName, productMeasure: $productMeasure, productMinimumQuantity: $productMinimumQuantity, productPrice: $productPrice)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Product &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.productId, productId) ||
                const DeepCollectionEquality()
                    .equals(other.productId, productId)) &&
            (identical(other.categoryId, categoryId) ||
                const DeepCollectionEquality()
                    .equals(other.categoryId, categoryId)) &&
            (identical(other.productName, productName) ||
                const DeepCollectionEquality()
                    .equals(other.productName, productName)) &&
            (identical(other.productMeasure, productMeasure) ||
                const DeepCollectionEquality()
                    .equals(other.productMeasure, productMeasure)) &&
            (identical(other.productMinimumQuantity, productMinimumQuantity) ||
                const DeepCollectionEquality().equals(
                    other.productMinimumQuantity, productMinimumQuantity)) &&
            (identical(other.productPrice, productPrice) ||
                const DeepCollectionEquality()
                    .equals(other.productPrice, productPrice)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(productId) ^
      const DeepCollectionEquality().hash(categoryId) ^
      const DeepCollectionEquality().hash(productName) ^
      const DeepCollectionEquality().hash(productMeasure) ^
      const DeepCollectionEquality().hash(productMinimumQuantity) ^
      const DeepCollectionEquality().hash(productPrice);

  @JsonKey(ignore: true)
  @override
  _$ProductCopyWith<_Product> get copyWith =>
      __$ProductCopyWithImpl<_Product>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_ProductToJson(this);
  }
}

abstract class _Product implements Product {
  const factory _Product(
      {String? userId,
      String? productId,
      String? categoryId,
      String? productName,
      Measure? productMeasure,
      int? productMinimumQuantity,
      double? productPrice}) = _$_Product;

  factory _Product.fromJson(Map<String, dynamic> json) = _$_Product.fromJson;

  @override
  String? get userId => throw _privateConstructorUsedError;
  @override
  String? get productId => throw _privateConstructorUsedError;
  @override
  String? get categoryId => throw _privateConstructorUsedError;
  @override
  String? get productName => throw _privateConstructorUsedError;
  @override
  Measure? get productMeasure => throw _privateConstructorUsedError;
  @override
  int? get productMinimumQuantity => throw _privateConstructorUsedError;
  @override
  double? get productPrice => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ProductCopyWith<_Product> get copyWith =>
      throw _privateConstructorUsedError;
}
