import 'package:freezed_annotation/freezed_annotation.dart';
part 'consumer.freezed.dart';
part 'consumer.g.dart';

@freezed
abstract class ConsumerAddress with _$ConsumerAddress {
  const factory ConsumerAddress(
      {@required String? consumerId,
      @required String? consumerPhone,
      @required String? consumerName,
      @required String? consumerHouse,
      @required String? consumerApartment}) = _ConsumerAddress;

  factory ConsumerAddress.fromJson(Map<String, dynamic> json) => _$ConsumerAddressFromJson(json);
}
