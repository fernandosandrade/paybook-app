import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:paybook_app/globals/serializers.dart';

part 'charge_dto.g.dart';

abstract class ChargeDto implements Built<ChargeDto, ChargeDtoBuilder> {
  ChargeDto._();
  factory ChargeDto([void Function(ChargeDtoBuilder) updates]) = _$ChargeDto;

  @BuiltValueField(wireName: "user_id")
  String get userId;

  @BuiltValueField(wireName: "book_id")
  String get bookID;

  @BuiltValueField(wireName: "charge_id")
  String get chargeId;

  static Serializer<ChargeDto> get serializer => _$chargeDtoSerializer;

  String toJson() {
    return serializers.toJson(ChargeDto.serializer, this);
  }

  Map<String, dynamic> toMap() {
    var serialized = serializers.serializeWith(ChargeDto.serializer, this) as Map<String, dynamic>;
    return Map<String, dynamic>.from(serialized);
  }
}
