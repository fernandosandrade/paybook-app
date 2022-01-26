import 'package:flutter/material.dart';
import 'package:paybook_app/services/enum_charge_status.dart';

class ChargeStatusChipWidget extends StatelessWidget {
  final EnumChargeStatus chargeStatus;

  ChargeStatusChipWidget({required this.chargeStatus});

  @override
  Widget build(BuildContext context) {
    Color color = Colors.white;
    String status = '';
    switch (this.chargeStatus) {
      case EnumChargeStatus.charge_open:
        color = Colors.limeAccent;
        status = 'em aberto';
        break;
      case EnumChargeStatus.charge_canceled:
        color = Colors.white30;
        status = 'cancelada';
        break;
      case EnumChargeStatus.charge_paid:
        color = Colors.green;
        status = 'paga';
        break;
      case EnumChargeStatus.waiting_payment:
        color = Colors.yellow;
        status = 'aguardando pagamento';
        break;
      default:
    }

    return Chip(label: Text('$status'), backgroundColor: color);
  }
}
