import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:paybook_app/data/models/book/book_basic_model.dart';
import 'package:paybook_app/data/models/cobranca/cobranca_111_model.dart';
import 'package:paybook_app/data/models/cobranca/cobranca_211_model.dart';
import 'package:paybook_app/data/models/destinatario.dart';
import 'package:paybook_app/data/models/user_model.dart';
import 'package:paybook_app/services/enum_tipo_book.dart';

part 'serializers.g.dart';

@SerializersFor([
  UserModel,
  BookBasicModel,
  Cobranca111Model,
  Cobranca211Model,
  Destinatario,
  EnumTipoBook,
])
final Serializers serializers = (_$serializers.toBuilder()..addPlugin(new StandardJsonPlugin())).build();
