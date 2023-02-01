import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'orderform.freezed.dart';
part 'orderform.g.dart';

Timestamp _timestampFromJson(Timestamp timestamp) => timestamp;
Timestamp? _timestampToJson(Timestamp? timestamp) => timestamp;

@freezed
abstract class OrderForm with _$OrderForm {
  const factory OrderForm({
    @required String? orderFormId,
    @required String? vendorId,
    @required OrderFormState? orderFormState,
    @required @JsonKey(name: 'timestamp', fromJson: _timestampFromJson, toJson: _timestampToJson) Timestamp? timestamp,
  }) = _OrderForm;

  factory OrderForm.fromJson(Map<String, dynamic> json) => _$OrderFormFromJson(json);
}

enum OrderFormState {
  @JsonValue("ACTIVE")
  ACTIVE,
  @JsonValue("INACTIVE")
  INACTIVE,
}
