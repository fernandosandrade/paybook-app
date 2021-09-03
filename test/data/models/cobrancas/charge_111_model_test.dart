import 'package:built_collection/built_collection.dart';
import 'package:paybook_app/data/models/charge/charge_111_model.dart';
import 'package:paybook_app/data/models/destinatario.dart';
import 'package:paybook_app/data/models/payment_link_preview_model.dart';
import 'package:paybook_app/data/repository/db_document.dart';
import 'package:paybook_app/data/repository/repository_collection_path.dart';
import 'package:paybook_app/services/enum_charge_type.dart';
import 'package:paybook_app/services/enum_cobranca_status.dart';
import 'package:paybook_app/services/enum_link_status.dart';
import 'package:test/test.dart';

void main() {
  test('serialization/deserialization test', () {
    var paymentLinkPreviewModel = PaymentLinkPreviewModel((p) => p
      ..id = 'id_teste'
      ..vencimento = DateTime.now().toUtc()
      ..status = EnumLinkStatus.waiting_paiment
      ..valor = 100);

    var receiver = Destinatario((d) => d
      ..nome = "fernando"
      ..email = "email@gmail.com"
      ..telefone = "999888777");

    var charge111Model = Charge111Model((s) => s
      ..id = "123"
      ..amount = 100
      ..creationDate = DateTime.now().toUtc()
      ..expirationDate = DateTime.now().add(Duration(days: 1)).toUtc()
      ..status = EnumCobrancaStatus.waiting_payment
      ..receiver = Destinatario((d) => d
        ..nome = "fernando"
        ..email = "email@gmail.com"
        ..telefone = "999888777").toBuilder()
      ..paymentLinks = [paymentLinkPreviewModel].build().toBuilder());

    var map = charge111Model.toMap();
    print(map);
    var dbDocument = DBDocument.fromMap(
        data: map, repositoryCollectionPath: RepositoryCollectionPath.of(["collection"]));
    print(dbDocument);
    var object = dbDocument.toObject(Charge111Model.serializer);
    expect(charge111Model, object);
  });
}
