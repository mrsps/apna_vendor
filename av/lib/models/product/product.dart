import 'package:freezed_annotation/freezed_annotation.dart';
part 'product.freezed.dart';
part 'product.g.dart';

@freezed
abstract class Product with _$Product {
  const factory Product({
    @required String? userId,
    @required String? productId,
    @required String? categoryId,
    @required String? productName,
    @required Measure? productMeasure,
    @required int? productMinimumQuantity,
    @required double? productPrice,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
}

enum Measure {
  @JsonValue("KILOGRAM")
  KILOGRAM,
  @JsonValue("FIVEHUNDREDGRAM")
  FIVEHUNDREDGRAM,
  @JsonValue("TWOFIFTYGRAM")
  TWOFIFTYGRAM,
  @JsonValue("HUNDREDGRAM")
  HUNDREDGRAM,
  @JsonValue("LITRE")
  LITRE,
  @JsonValue("FIVEHUNDREDML")
  FIVEHUNDREDML,
  @JsonValue("TWOFIFTYML")
  TWOFIFTYML,
  @JsonValue("HUNDREDML")
  HUNDREDML,
  @JsonValue("UNIT")
  UNIT,
  @JsonValue("DOZEN")
  DOZEN
}

String measureString(Measure measure) {
  switch (measure) {
    case Measure.KILOGRAM:
      return 'kg';
    case Measure.FIVEHUNDREDGRAM:
      return '500g';
    case Measure.TWOFIFTYGRAM:
      return '250g';
    case Measure.HUNDREDGRAM:
      return '100g';
    case Measure.LITRE:
      return 'l';
    case Measure.FIVEHUNDREDML:
      return '500ml';
    case Measure.TWOFIFTYML:
      return '250ml';
    case Measure.HUNDREDML:
      return '100ml';
    case Measure.UNIT:
      return 'pc';
    case Measure.DOZEN:
      return 'dozen';
  }
}

Measure stringMeasure(String s) {
  switch (s) {
    case 'kg':
      return Measure.KILOGRAM;
    case '500g':
      return Measure.FIVEHUNDREDGRAM;
    case '250g':
      return Measure.TWOFIFTYGRAM;
    case '100g':
      return Measure.HUNDREDGRAM;
    case 'l':
      return Measure.LITRE;
    case '500ml':
      return Measure.FIVEHUNDREDML;
    case '250ml':
      return Measure.TWOFIFTYML;
    case '100ml':
      return Measure.HUNDREDML;
    case 'pc':
      return Measure.UNIT;
    case 'dozen':
      return Measure.DOZEN;
  }
  return Measure.KILOGRAM;
}
