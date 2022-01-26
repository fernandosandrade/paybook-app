import 'package:paybook_app/data/repository/repository_collection_path.dart';

import 'charges_collection.dart';

class PaymentLinksCollection extends ChargesCollection {
  static const String collectionName = 'payment_links';

  String? paymentLinkId;

  PaymentLinksCollection(
      {required String userId,
      required String bookId,
      required String chargeId,
      this.paymentLinkId})
      : super(userId: userId, bookId: bookId, chargeId: chargeId);

  /// ``/users/:user_id/books/:book_id/charges/:charge_id/payment_links/:payment_link_id``
  RepositoryCollectionPath collectionPath() {
    return RepositoryCollectionPath.of(
        [super.collectionPath().path, collectionName, this.paymentLinkId ?? '']);
    // return '${super.path()}/$collectionName/$chargeId';
  }
}
