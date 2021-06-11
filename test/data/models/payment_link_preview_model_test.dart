import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:paybook_app/data/models/payment_link_preview_model.dart';
import 'package:paybook_app/globals/serializers.dart';
import 'package:paybook_app/services/enum_link_status.dart';

void main() {
  test('payment_link_preview_model', () {
    var previewModel = PaymentLinkPreviewModel((s) => s
      ..id = 'id_teste'
      ..status = EnumLinkStatus.waiting_paiment
      ..valor = 100.00
      ..vencimento = DateTime.now().toUtc());
    var map = previewModel.toMap();
    var fromJson = serializers.fromJson(PaymentLinkPreviewModel.serializer, json.encode(map));
    print(fromJson);
    print(map);
    expect(previewModel, fromJson);
  });
}
