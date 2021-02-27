import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GlobalDialog {
  static Future showInfoDialog(
      {@required BuildContext context, @required String titulo, @required String mensagem}) async {
    await showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(titulo),
              content: Text(mensagem),
              actions: <Widget>[
                FlatButton(onPressed: () => Navigator.of(context).pop(), child: Text('fechar'))
              ],
            ));
  }
}
