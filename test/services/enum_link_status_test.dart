import 'package:flutter_test/flutter_test.dart';
import 'package:paybook_app/globals/serializers.dart';
import 'package:paybook_app/services/enum_link_status.dart';

void main() {
  test('enum link status', () {
    var json = serializers.toJson(EnumLinkStatus.serializer, EnumLinkStatus.waiting_paiment);
    print(json);
  });
}
