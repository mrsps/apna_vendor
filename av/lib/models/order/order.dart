import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'order.freezed.dart';
part 'order.g.dart';

Timestamp _timestampFromJson(Timestamp timestamp) => timestamp;
Timestamp? _timestampToJson(Timestamp? timestamp) => timestamp;

@freezed
abstract class Order with _$Order {
  const factory Order(
      {@required
          String? orderId,
      @required
          String? consumerId,
      @required
          String? leaderId,
      @required
          String? vendorId,
      @required
          OrderState? orderState,
      @required
          PaymentState? paymentState,
      @required
      @JsonKey(name: 'timestamp', fromJson: _timestampFromJson, toJson: _timestampToJson)
          Timestamp? timestamp,
      @required
          Map<String, int>? products}) = _Order;

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
}

enum OrderState {
  @JsonValue("CREATED")
  CREATED,
  @JsonValue("SHIPPED")
  SHIPPED,
  @JsonValue("CANCELLED")
  CANCELLED,
  @JsonValue("DELIVERED")
  DELIVERED,
}

enum PaymentState {
  @JsonValue("PENDING")
  PENDING,
  @JsonValue("DONE")
  DONE,
}
