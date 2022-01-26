import 'package:built_value/serializer.dart';
import 'package:logging/logging.dart';
import 'package:paybook_app/data/collections/payment_links_collection.dart';
import 'package:paybook_app/data/models/payment_link_model.dart';
import 'package:paybook_app/data/repository/document_repository.dart';

abstract class IPaymentLinkService {
  Future create(PaymentLinkModel model);

  Future update(PaymentLinkModel model);

  Future delete(PaymentLinkModel model);

  Future<List<PaymentLinkModel?>> listAll();

  Future<PaymentLinkModel?> findById(String id);
}

class PaymentLinkService implements IPaymentLinkService {
  final log = Logger('PaymentLinkService');

  final PaymentLinksCollection _paymentLinksCollection;

  final Serializer<PaymentLinkModel> _serializer;

  PaymentLinkService(
      {required PaymentLinksCollection paymentLinksCollection,
      required Serializer<PaymentLinkModel> serializer})
      : this._paymentLinksCollection = paymentLinksCollection,
        this._serializer = serializer;

  @override
  Future create(PaymentLinkModel model) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future delete(PaymentLinkModel model) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future update(PaymentLinkModel model) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<PaymentLinkModel?> findById(String id) {
    // TODO: implement findById
    throw UnimplementedError();
  }

  @override
  Future<List<PaymentLinkModel?>> listAll() {
    return DocumentRepository.onCollection(this._paymentLinksCollection.collectionPath())
        .listAll()
        .then((docList) => docList.isNotEmpty
            ? docList.map((dbDoc) => dbDoc.toObject(this._serializer)).toList()
            : List.empty());
  }
}
