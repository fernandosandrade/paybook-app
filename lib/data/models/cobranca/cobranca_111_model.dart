import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:paybook_app/data/models/cobranca/cobranca_base_model.dart';
import 'package:paybook_app/globals/serializers.dart';

// required imports for correctly build of superclass CobrancaBaseModel
import 'package:built_collection/built_collection.dart';
import 'package:paybook_app/data/models/destinatario.dart';
import 'package:paybook_app/services/enum_cobranca_status.dart';
import 'package:paybook_app/data/models/payment_link_preview_model.dart';

part 'cobranca_111_model.g.dart';

abstract class Cobranca111Model extends Object
    implements CobrancaBaseModel, Built<Cobranca111Model, Cobranca111ModelBuilder> {
  Cobranca111Model._();
  factory Cobranca111Model([void Function(Cobranca111ModelBuilder) updates]) = _$Cobranca111Model;

  // fields

  static Serializer<Cobranca111Model> get serializer => _$cobranca111ModelSerializer;

  @override
  Map<String, dynamic> toMap() {
    var serialized = serializers.serializeWith(Cobranca111Model.serializer, this) as Map<String, dynamic>;
    return Map<String, dynamic>.from(serialized);
  }
}
