import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/cobranca_101_model.dart';

abstract class ICobrancaSimplesRepository {
  Stream<List<Cobranca101Model>> listByBookId(String bookId);
  Future<Cobranca101Model> getByIdCobranca(String bookId);
  Future save(Cobranca101Model model);
  Future delete(Cobranca101Model model);
  Future<Stream<Cobranca101Model>> getByDocumentId(String documentId);
}

class CobrancaSimplesRepository implements ICobrancaSimplesRepository {
  static const String COBRANCA_SIMPLES_COLLECTION = 'cobranca_simples';
  final Firestore firestore;
  final CollectionReference collectionReference =
      Firestore.instance.collection(COBRANCA_SIMPLES_COLLECTION);

  CobrancaSimplesRepository({@required this.firestore});

  //dispose will be called automatically
  @override
  void dispose() {}

  @override
  Stream<List<Cobranca101Model>> listByBookId(String bookId) {
    return collectionReference.where('id_book', isEqualTo: bookId).snapshots().map(
        (query) => query.documents.map((doc) => Cobranca101Model.fromJson(doc?.data)).toList());
  }

  @override
  Future<Stream<Cobranca101Model>> getByDocumentId(String documentId) async {
    return collectionReference
        .document(documentId)
        .snapshots()
        .map((doc) => Cobranca101Model.fromJson(doc.data));
  }

  @override
  Future save(Cobranca101Model model) async {
    //var total = (await collectionReference.getDocuments()).documents.length;
    if (model.reference == null) {
      model.reference = await collectionReference.add(model.toJson());
    } else {
      model.reference.updateData(model.toJson());
    }
  }

  Future delete(Cobranca101Model model) {
    return model.reference.delete();
  }

  @override
  Future<Cobranca101Model> getByIdCobranca(String idCobranca) {
    return collectionReference
        .where('id_cobranca', isEqualTo: idCobranca)
        .getDocuments()
        .then((value) => value.documents.isNotEmpty
            ? value.documents.map((doc) {
                var cobrancaSimplesModel = Cobranca101Model.fromJson(doc.data);
                cobrancaSimplesModel.reference = doc.reference;
                return cobrancaSimplesModel;
              }).first
            : throw Exception('nenhuma cobranca encontrada idCobranca=$idCobranca.'));
  }
}
