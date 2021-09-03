import 'package:built_value/serializer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logging/logging.dart';
import 'package:paybook_app/data/collections/charges_collection.dart';
import 'package:paybook_app/data/models/book/abstract_book_base_model.dart';
import 'package:paybook_app/data/models/charge/abstract_charge_base_model.dart';
import 'package:paybook_app/data/repository/db_document.dart';
import 'package:paybook_app/data/repository/document_repository.dart';
import 'package:paybook_app/data/repository/document_repository_model.dart';
import 'package:paybook_app/http/charge_dto.dart';
import 'package:paybook_app/http/http_client.dart';
import 'package:paybook_app/http/http_service.dart';
import 'package:paybook_app/services/enum_charge_type.dart';

abstract class IChargeService<T extends AbstractChargeBaseModel> {
  Future create(T model);

  Future update(T model);

  Future delete(T model);

  Stream<List<T?>> listAll();

  /// find charge by id
  Future<T?> findById(String id);
}

class ChargeService<T extends AbstractChargeBaseModel> implements IChargeService<T> {
  final log = Logger('CobrancaService');

  final ChargesCollection _chargesCollection;

  final Serializer<T> _serializer;

  ChargeService({required ChargesCollection chargesCollection, required Serializer<T> serializer})
      : this._chargesCollection = chargesCollection,
        this._serializer = serializer;

  @override
  Future create(T model) {
    log.info('creating $model on ${_chargesCollection.collectionPath()}');
    return DocumentRepository.save(DBDocument.fromMap(
            data: model.toMap(), repositoryCollectionPath: _chargesCollection.collectionPath()))
        .then((_) {
      ChargeDto dto = ChargeDto((c) => c
        ..userId = _chargesCollection.userId
        ..bookID = _chargesCollection.bookId
        ..chargeId = model.id);
      HttpService.Charges.generateLinks(model.chargeType, dto);
    });
  }

  Future update(T model) {
    log.info('updating $model on ${_chargesCollection.collectionPath()}');
    return DocumentRepository.save(DBDocument.fromMap(
        data: model.toMap(), repositoryCollectionPath: _chargesCollection.collectionPath()));
  }

  @override
  Future delete(T model) {
    log.info('deleting $model on ${_chargesCollection.collectionPath()}');
    return DocumentRepository.delete(DBDocument.fromMap(
        data: model.toMap(), repositoryCollectionPath: _chargesCollection.collectionPath()));
  }

  @override
  Stream<List<T?>> listAll() {
    return DocumentRepository.onCollection(this._chargesCollection.collectionPath())
        .listAllAsStream()
        .map((docList) => docList.isNotEmpty
            ? docList.map((dbDoc) => dbDoc.toObject(this._serializer)).toList()
            : List.empty());
  }

  @override
  Future<T?> findById(String id) {
    return DocumentRepository.onCollection(this._chargesCollection.collectionPath())
        .findByID(id)
        .then((doc) => doc?.toObject(this._serializer));
  }
}
