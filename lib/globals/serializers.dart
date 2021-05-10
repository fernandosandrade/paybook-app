import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:paybook_app/data/models/cobranca/cobranca_111_model.dart';
import 'package:paybook_app/data/models/cobranca/cobranca_211_model.dart';
import 'package:paybook_app/data/models/destinatario.dart';

part 'serializers.g.dart';

@SerializersFor([
  Cobranca111Model,
  Cobranca211Model,
  Destinatario,
])
final Serializers serializers = (_$serializers.toBuilder()..addPlugin(new StandardJsonPlugin())).build();
