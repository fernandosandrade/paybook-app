import 'package:flutter/material.dart';

class CustomWidget {
  /// appbar default para utilizacao geral no app
  static PreferredSize appbar({required String titulo}) {
    return PreferredSize(
      preferredSize: Size.fromHeight(50.0),
      child: AppBar(
        title: Text(titulo, style: TextStyle(color: Colors.black)),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
    );
  }
}
