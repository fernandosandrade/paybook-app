import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:paybook_app/data/models/charge/abstract_charge_base_model.dart';
import 'package:paybook_app/globals/serializers.dart';

// required imports for correctly build of superclass CobrancaBaseModel
import 'package:built_collection/built_collection.dart';
import 'package:paybook_app/data/models/destinatario.dart';
import 'package:paybook_app/services/enum_charge_type.dart';
import 'package:paybook_app/services/enum_charge_status.dart';
import 'package:paybook_app/data/models/payment_link_preview_model.dart';

part 'charge_111_model.g.dart';

abstract class Charge111Model extends Object
    implements AbstractChargeBaseModel, Built<Charge111Model, Charge111ModelBuilder> {
  Charge111Model._();
  // factory Charge111Model([void Function(Charge111ModelBuilder) updates]) = _$Charge111Model;

  factory Charge111Model(void Function(Charge111ModelBuilder) updates) =>
      new _$Charge111Model((b) => b
        ..chargeType = EnumChargeType.C_111
        ..update(updates));

  @BuiltValueField(wireName: "expiration_date")
  DateTime get expirationDate;

  static Serializer<Charge111Model> get serializer => _$charge111ModelSerializer;

  Map<String, dynamic> toMap() {
    var serialized =
        serializers.serializeWith(Charge111Model.serializer, this) as Map<String, dynamic>;
    return Map<String, dynamic>.from(serialized);
  }
}
