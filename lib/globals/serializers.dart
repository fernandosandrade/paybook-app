import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:built_collection/built_collection.dart';
import 'package:paybook_app/data/models/book/book_101_model.dart';

import 'package:paybook_app/data/models/book/book_basic_model.dart';
import 'package:paybook_app/data/models/charge/charge_111_model.dart';
import 'package:paybook_app/data/models/destinatario.dart';
import 'package:paybook_app/data/models/payment_link_model.dart';
import 'package:paybook_app/data/models/payment_link_preview_model.dart';
import 'package:paybook_app/data/models/user_model.dart';
import 'package:paybook_app/data/repository/timestamp_serializer_plugin.dart';
import 'package:paybook_app/http/charge_dto.dart';
import 'package:paybook_app/services/enum_charge_status.dart';
import 'package:paybook_app/services/enum_link_status.dart';
import 'package:paybook_app/services/enum_book_type.dart';
import 'package:paybook_app/services/enum_charge_type.dart';

part 'serializers.g.dart';

@SerializersFor([
  UserModel,
  Destinatario,

  // books
  BookBasicModel,
  Book101Model,

  //charges
  Charge111Model,

  //payment links
  PaymentLinkModel,
  PaymentLinkPreviewModel,

  //dto
  ChargeDto,

  //enums
  EnumChargeStatus,
  EnumBookType,
  EnumChargeType,
  EnumLinkStatus,
])
final Serializers serializers = (_$serializers.toBuilder()
      ..addPlugin(new StandardJsonPlugin())
      ..addPlugin(new TimestampSerializerPlugin()))
    .build();
