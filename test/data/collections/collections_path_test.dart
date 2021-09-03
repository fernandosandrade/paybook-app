import 'package:flutter_test/flutter_test.dart';
import 'package:paybook_app/data/collections/books_collection.dart';
import 'package:paybook_app/data/collections/charges_collection.dart';
import 'package:paybook_app/data/collections/users_collection.dart';

void main() {
  test('test collection path', () {
    var usersCollection = UsersCollection();
    expect(usersCollection.collectionPath().path, 'users');
    usersCollection.userId = 'QFzsUBuDKvYmCggRSAlE';
    expect(usersCollection.collectionPath().path, 'users/QFzsUBuDKvYmCggRSAlE');

    var booksCollection = BooksCollection(userId: 'QFzsUBuDKvYmCggRSAlE');
    expect(booksCollection.collectionPath().path, 'users/QFzsUBuDKvYmCggRSAlE/books');
    booksCollection.bookId = '50zjPKx82aiAgjxzTKbY';
    expect(booksCollection.collectionPath().path,
        'users/QFzsUBuDKvYmCggRSAlE/books/50zjPKx82aiAgjxzTKbY');

    var chargesCollection =
        ChargesCollection(bookId: '50zjPKx82aiAgjxzTKbY', userId: 'QFzsUBuDKvYmCggRSAlE');
    expect(chargesCollection.collectionPath().path,
        'users/QFzsUBuDKvYmCggRSAlE/books/50zjPKx82aiAgjxzTKbY/charges');
    chargesCollection.chargeId = 'JE4RTA1UbozO4r6fIkMU';
    expect(chargesCollection.collectionPath().path,
        'users/QFzsUBuDKvYmCggRSAlE/books/50zjPKx82aiAgjxzTKbY/charges/JE4RTA1UbozO4r6fIkMU');
  });

  test('get ids from collection', () {
    var chargesCollection =
        ChargesCollection(bookId: '50zjPKx82aiAgjxzTKbY', userId: 'QFzsUBuDKvYmCggRSAlE');
    expect(chargesCollection.collectionPath().path,
        'users/QFzsUBuDKvYmCggRSAlE/books/50zjPKx82aiAgjxzTKbY/charges');
    chargesCollection.chargeId = 'JE4RTA1UbozO4r6fIkMU';
    expect(chargesCollection.collectionPath().path,
        'users/QFzsUBuDKvYmCggRSAlE/books/50zjPKx82aiAgjxzTKbY/charges/JE4RTA1UbozO4r6fIkMU');

    expect(chargesCollection.userId, 'QFzsUBuDKvYmCggRSAlE');
    expect(chargesCollection.bookId, '50zjPKx82aiAgjxzTKbY');
    expect(chargesCollection.chargeId, 'JE4RTA1UbozO4r6fIkMU');
  });
}
