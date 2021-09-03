import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paybook_app/data/models/charge/charge_111_model.dart';
import 'package:paybook_app/routes/app_pages.dart';
import 'package:paybook_app/services/enum_book_type.dart';
import 'package:paybook_app/services/enum_charge_type.dart';
import 'package:paybook_app/themes/app_text_style.dart';
import 'package:paybook_app/themes/default_icons.dart';
import 'package:paybook_app/utils/formatters.dart';

class CardCobranca111 extends StatelessWidget {
  final String bookId;
  final Charge111Model charge111Model;

  CardCobranca111({required this.bookId, required this.charge111Model});

  @override
  Widget build(BuildContext context) {
    var nomeDestinatario = charge111Model.receiver.nome;
    var valor = 'R\$ ${Formatters.currencyPtBr(charge111Model.amount)}';
    var vencimento = Formatters.simpleDate(charge111Model.expirationDate);
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
              AppRoutes.Charges.chargeFormURLBuild(
                  tipoBook: EnumBookType.B_101,
                  tipoCobranca: EnumChargeType.C_111,
                  bookId: bookId,
                  chargeId: charge111Model.id),
              arguments: charge111Model),
        ));
  }

  Widget cartao() {
    var nomeDestinatario = charge111Model.receiver.nome;
    var valor = 'R\$ ${Formatters.currencyPtBr(charge111Model.amount)}';
    var vencimento = Formatters.simpleDate(charge111Model.expirationDate);
    return Center(
      child: Card(
        elevation: 2,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () =>
              Get.toNamed(AppRoutes.Charges.editCharge111FormURLTemplate + ':' + charge111Model.id),
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
                        icon: Icon(DefaultIcons.vencimento),
                        onPressed: () => print('botao1'),
                      ),
                      new IconButton(
                        icon: Icon(
                          DefaultIcons.conta,
                          color: Colors.redAccent,
                        ),
                        onPressed: () => print('botao2'),
                      ),
                      new IconButton(
                        icon: Icon(DefaultIcons.copia),
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
