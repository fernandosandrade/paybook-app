import 'package:flutter/material.dart';

class CustomWidget {
  /// appbar default para utilizacao geral no app
  static Widget appbar({required String titulo}) {
    return AppBar(
      title: Text(titulo, style: TextStyle(color: Colors.black)),
      iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }
}
