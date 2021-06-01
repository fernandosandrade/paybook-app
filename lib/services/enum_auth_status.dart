import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'enum_auth_status.g.dart';

class EnumAuthStatus extends EnumClass {
  static Serializer<EnumAuthStatus> get serializer => _$enumAuthStatusSerializer;

  static const EnumAuthStatus LOGGED_IN = _$LOGGED_IN;
  static const EnumAuthStatus NOT_LOGGED = _$NOT_LOGGED;
  static const EnumAuthStatus UNDETERMINED = _$UNDETERMINED;

  const EnumAuthStatus._(String name) : super(name);

  static BuiltSet<EnumAuthStatus> get values => _$values;
  static EnumAuthStatus valueOf(String name) => _$valueOf(name);
}
