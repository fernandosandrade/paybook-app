import 'package:flutter/material.dart';
import 'package:paybook_app/themes/app_text_style.dart';
import 'package:paybook_app/themes/default_icons.dart';

class SeletorCobrancaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
            child: Column(
          children: [
            Text(
              'seleção da cobrança',
              style: AppTextStyle.grande,
              textAlign: TextAlign.center,
            ),
            ListTile(
              contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
              title: Text(
                'cobrança simples',
                style: AppTextStyle.medio,
              ),
              subtitle: Text(
                  'cobranca única, que será enviada para um destinatário escolhido, com o vencimento na data desejada.'),
              trailing: Icon(DefaultIcons.SETA_DIREITA),
            ),
            Divider(),
            ListTile(
              contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
              title: Text(
                'cobrança parcelada',
                style: AppTextStyle.medio,
              ),
              subtitle: Text('defina o valor total e divida em quantas parcelas pretende cobrar.'),
              trailing: Icon(DefaultIcons.SETA_DIREITA),
            ),
          ],
        )));
  }
}
