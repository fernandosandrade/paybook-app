import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:paybook_app/modules/books/charge111/charge_111_details_controller.dart';
import 'package:paybook_app/themes/default_icons.dart';
import 'package:paybook_app/utils/formatters.dart';

class Charge111DetailsPage extends GetView<Charge111DetailsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('appbarTitle'),
        ),
        body: _BodyWidget());
  }
}

class _BodyWidget extends GetView<Charge111DetailsController> {
  @override
  Widget build(BuildContext context) {
    // return Text('${controller.charge.receiver.nome}');
    return Column(
      children: <Widget>[
        ListTile(
          leading: const Icon(DefaultIcons.user_1),
          title: Text('destinatario'),
          subtitle: Text('${controller.charge.receiver.nome}'),
        ),
        ListTile(
          leading: const Icon(DefaultIcons.money),
          title: Text('valor'),
          subtitle: Text('R\$ ${Formatters.currencyPtBr(controller.charge.amount)}'),
        ),
        ListTile(
          leading: const Icon(DefaultIcons.vencimento),
          title: Text('criação'),
          subtitle: Text('${Formatters.simpleDate(controller.charge.creationDate)}'),
        ),
        ListTile(
          leading: const Icon(DefaultIcons.vencimento),
          title: Text('vencimento'),
          subtitle: Text('${Formatters.simpleDate(controller.charge.expirationDate)}'),
        ),
        _PaymentLinksWidget(),
      ],
    );
  }
}

class _PaymentLinksWidget extends GetView<Charge111DetailsController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListTile(
      leading: const Icon(DefaultIcons.link),
      title: Text('link de pagamento'),
      subtitle: Obx(() {
        return controller.paymentLinks.isEmpty
            ? Text('loading...')
            : Text('${controller.paymentLinks.first!.url}');
      }),
    );
  }
}
