import 'package:firebase_core/firebase_core.dart';
import 'package:built_collection/built_collection.dart';
import 'package:paybook_app/data/models/cobranca/cobranca_111_model.dart';
import 'package:paybook_app/data/models/destinatario.dart';
import 'package:paybook_app/data/models/payment_link_preview_model.dart';
import 'package:paybook_app/data/repository/db_document.dart';
import 'package:paybook_app/data/repository/repository_collection_path.dart';
import 'package:paybook_app/services/enum_cobranca_status.dart';
import 'package:paybook_app/services/enum_link_status.dart';
import 'package:test/test.dart';

void main() {
  test('serialization/deserialization test', () {
    var paymentLinkPreviewModel = PaymentLinkPreviewModel((p) => p
      ..id = 'id_teste'
      ..vencimento = DateTime.now().toUtc()
      ..status = EnumLinkStatus.waiting_paiment
      ..valor = 100.00);

    var destinatario = Destinatario((d) => d
      ..nome = "fernando"
      ..email = "email@gmail.com"
      ..telefone = "999888777");

    var cobranca111model = Cobranca111Model((s) => s
      ..id = "123"
      ..idBook = "book_id_123"
      ..valor = 1
      ..dtCriacao = DateTime.now().toUtc()
      ..dtVencimento = DateTime.now().add(Duration(days: 1)).toUtc()
      ..status = EnumCobrancaStatus.waiting_payment
      ..destinatario = Destinatario((d) => d
        ..nome = "fernando"
        ..email = "email@gmail.com"
        ..telefone = "999888777").toBuilder()
      ..linksPagamento = [paymentLinkPreviewModel].build().toBuilder());

    var map = cobranca111model.toMap();
    print(map);
    var dbDocument =
        DBDocument.fromMap(data: map, repositoryCollectionPath: RepositoryCollectionPath.of(["collection"]));
    print(dbDocument);
    var object = dbDocument.toObject(Cobranca111Model.serializer);
    expect(cobranca111model, object);
  });
}
