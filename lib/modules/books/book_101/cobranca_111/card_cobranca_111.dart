import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/models/cobranca_101_model.dart';
import '../../../../routes/app_pages.dart';
import '../../../../themes/app_text_style.dart';
import '../../../../utils/formatters.dart';

class CardCobranca111 extends StatelessWidget {
  final Cobranca101Model cobrancaSimplesModel;

  CardCobranca111({this.cobrancaSimplesModel});

  @override
  Widget build(BuildContext context) {
    var nomeDestinatario = cobrancaSimplesModel.destinatario.nome;
    var valor = 'R\$ ${Formatters.currencyPtBr(cobrancaSimplesModel.valor)}';
    var vencimento = Formatters.simpleDate(cobrancaSimplesModel.dtVencimento);
    //return cartao();
    return Card(
      elevation: 2,
      child: ListTile(
        title: Text(nomeDestinatario),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(valor),
              Text(vencimento),
            ],
          ),
        ),
        contentPadding: EdgeInsets.only(top: 15, bottom: 15),
        leading: IconButton(
          icon: Icon(
            Icons.remove_circle_outline,
            color: Colors.red,
          ),
          onPressed: () => print('excluir'),
        ),
        onTap: () => Get.toNamed(
            AppRoutes.COBRANCA_SIMPLES_FORM + '?id_cobranca=' + cobrancaSimplesModel.idCobranca),
      ),
    );
  }

  Widget cartao() {
    var nomeDestinatario = cobrancaSimplesModel.destinatario.nome;
    var valor = 'R\$ ${Formatters.currencyPtBr(cobrancaSimplesModel.valor)}';
    var vencimento = Formatters.simpleDate(cobrancaSimplesModel.dtVencimento);
    return Center(
      child: Card(
        elevation: 2,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () => Get.toNamed(
              AppRoutes.COBRANCA_SIMPLES_FORM + '?id_cobranca=' + cobrancaSimplesModel.idCobranca),
          child: Container(
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Row(
                children: <Widget>[
                  Text(
                    nomeDestinatario,
                    style: AppTextStyle.normalDestacado,
                  ),
                  Spacer(),
                  new ButtonBar(
                    children: <Widget>[
                      new IconButton(
                        icon: Icon(Icons.access_alarm),
                        onPressed: () => print('botao1'),
                      ),
                      new IconButton(
                        icon: Icon(
                          Icons.account_balance,
                          color: Colors.redAccent,
                        ),
                        onPressed: () => print('botao2'),
                      ),
                      new IconButton(
                        icon: Icon(Icons.content_copy),
                        onPressed: () => print('botao3'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
