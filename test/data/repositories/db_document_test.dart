import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('map test', () {
    final data = {"data": new Timestamp.now()};
    print(json.encode(data, toEncodable: (value) {
      if (value is Timestamp) {}
    }));
  });
}
