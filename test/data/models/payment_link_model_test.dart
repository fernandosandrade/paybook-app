import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:paybook_app/data/models/payment_link_model.dart';
import 'package:paybook_app/data/models/payment_link_preview_model.dart';
import 'package:paybook_app/globals/serializers.dart';
import 'package:paybook_app/services/enum_link_status.dart';

void main() {
  test('conversion test', () {
    var build = [
      PaymentLinkPreviewModel((p) => p
        ..id = 'id_teste'
        ..vencimento = DateTime.now().toUtc()
        ..status = EnumLinkStatus.waiting_paiment
        ..valor = 1000)
    ].build();

    var paymentLinkModel = PaymentLinkModel((s) => s
      ..id = 'id_teste'
      ..descricao = 'blablabla'
      ..idCobranca = 'cobranca123'
      ..status = EnumLinkStatus.waiting_paiment
      ..url = 'https://teste'
      ..valorPrincipal = 10000
      ..valorTaxas = 1000
      ..vencimento = DateTime.now().toUtc());
    // ..linksPagamento = build.toBuilder()
    var map = paymentLinkModel.toMap();
    var mapAsJson = json.encode(map);
    print(mapAsJson);
    var fromJson = serializers.fromJson(PaymentLinkModel.serializer, mapAsJson);
    print(fromJson);
  });
}
