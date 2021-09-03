import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:paybook_app/globals/enum_form_action.dart';
import 'package:paybook_app/themes/app_text_style.dart';
import 'package:paybook_app/themes/default_icons.dart';
import 'package:paybook_app/utils/currency_pt_br_input_formatter.dart';
import 'package:paybook_app/widgets/custom_widget.dart';

import 'charge_111_form_controller.dart';

class Charge111FormPage extends GetView<Charge111FormController> {
  final _dateFormat = DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: CustomWidget.appbar(titulo: controller.tituloForm),
        body: ModalProgressHUD(
          child: _form(),
          inAsyncCall: controller.isInAsyncCall.value,
          opacity: 0.5,
          progressIndicator: CircularProgressIndicator(),
        ),
      );
    });
  }

  Widget _form() {
    return SingleChildScrollView(
        child: Form(
      key: controller.formKey,
      child: Container(
        height: Get.height * 0.8,
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            inputValor(),
            inputDestinatario(),
            inputVencimento(),
            botaoFinalizar(),
          ],
        ),
      ),
    ));
  }

  inputValor() {
    return Center(
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        Expanded(
          child: TextFormField(
            controller: controller.valorController,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
                border: InputBorder.none, contentPadding: EdgeInsets.only(left: 15)),
            style: AppTextStyle.grande,
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              // WhitelistingTextInputFormatter.digitsOnly,
              CurrencyPtBrInputFormatter(maxDigits: 8),
            ],
            // onSaved: (String val) => controller.valor =
            //     double.parse(val.replaceAll(new RegExp('[^0-9]'), "")) /
            //         100),
            onSaved: (val) {
              if (val != null)
                controller.valor = int.parse(val.replaceAll(new RegExp('[^0-9]'), ""));
            },
          ),
        )
      ]),
    );
  }

  inputDestinatario() {
    return GestureDetector(
        onTap: () => controller.editarDestinatario(),
        child: Obx(() {
          var destinatario = controller.destinatario.value;
          if (destinatario == null) {
            return Container(
                child: TextButton.icon(
                    label: Text(
                      'destinatário',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    icon: Icon(
                      DefaultIcons.CONTACT_1,
                      color: Colors.black,
                    ),
                    onPressed: null));
          } else {
            return Container(
                child: InputDecorator(
                    decoration:
                        InputDecoration(labelText: 'destinatario', border: InputBorder.none),
                    child: InputChip(
                        avatar: CircleAvatar(
                          //backgroundImage: MemoryImage(_.destinatario.value.avatar),
                          child: Text('${destinatario.nome.substring(0, 1)}'),
                        ),
                        label: Text('${destinatario.nome}'),
                        onPressed: () => controller.editarDestinatario())));
          }
        }));
  }

  inputVencimento() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
            child: InputDecorator(
          decoration: InputDecoration(labelText: 'vencimento', border: InputBorder.none),
          child: Obx(
            () => Text(
              _dateFormat.format(controller.dataVencimento.value),
              textAlign: TextAlign.center,
              style: AppTextStyle.medio,
            ),
          ),
        )),
        _editorVencimento(),
      ],
    );
  }

  _editorVencimento() {
    if (controller.formAction == EnumFormAction.INCLUIR) {
      return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ToggleButtons(
                renderBorder: false,
                children: controller.vencimentos.values.toList(),
                onPressed: (index) => controller.changeToggleVencimento(index),
                isSelected: controller.toggleVencimentos.value),
            IconButton(icon: Icon(Icons.calendar_today), onPressed: _datePicker),
          ],
        ),
      );
    } else {
      return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.remove),
                onPressed: () => controller.changeDataVencimento(removeDias: 1)),
            SizedBox(
                width: 30,
                child: TextFormField(
                  controller: controller.editorDiasVencimentoController,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(border: InputBorder.none),
                  onChanged: (value) => controller.changeDataVencimento(addDias: int.parse(value)),
                )),
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () => controller.changeDataVencimento(addDias: 1)),
            IconButton(icon: Icon(Icons.calendar_today), onPressed: _datePicker),
          ],
        ),
      );
    }
  }
/*

          ],
        );
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
                child: InputDecorator(
              decoration: InputDecoration(labelText: 'vencimento', border: InputBorder.none),
              child: Text(
                _dateFormat.format(_.dataVencimento.value),
                textAlign: TextAlign.center,
                style: AppTextStyle.medio,
              ),
            )),
            Container(
              child: Row(
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () => _.changeDataVencimento(removeDias: 1)),
                  SizedBox(
                      width: 30,
                      child: TextFormField(
                        controller: _.editorDiasVencimentoController,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(border: InputBorder.none),
                        onChanged: (value) => _.changeDataVencimento(addDias: int.parse(value)),
                      )),
                  IconButton(
                      icon: Icon(Icons.add), onPressed: () => _.changeDataVencimento(addDias: 1)),
                  IconButton(icon: Icon(Icons.calendar_today), onPressed: _datePicker),
                ],
              ),
            ),
          ],
        );
      } else
        throw Exception('nao foi possivel identificar a acao do form');
    });
  }*/

  Widget botaoFinalizar() {
    if (controller.formAction == EnumFormAction.INCLUIR) {
      return botaoIncluirCobranca();
    } else if (controller.formAction == EnumFormAction.ALTERAR) {
      return botaoAlterarCobranca();
    } else
      throw Exception('nao foi possivel identificar a acao do form');
  }

  botaoIncluirCobranca() {
    return ElevatedButton(child: new Text('incluir cobrança'), onPressed: _incluirCobranca);
  }

  botaoAlterarCobranca() {
    return ElevatedButton(child: new Text('alterar cobrança'), onPressed: _alterarCobranca);
  }

  void _incluirCobranca() {
    controller.formKey.currentState.save();
    controller.isInAsyncCall.value = true;
    controller.incluirCobranca().then((value) {
      controller.isInAsyncCall.value = false;
      return Get.dialog(AlertDialog(
        title: Text('cobrança registrada!'),
        content: Text('sua nova cobrança foi registrada com sucesso'),
        actions: [TextButton(onPressed: () => Get.back(), child: Text('ok'))],
      )).then((value) => Get.back());
    });
  }

  void _alterarCobranca() {
    controller.formKey.currentState.save();
    controller.isInAsyncCall.value = true;
    controller.alterarCobranca().then((value) {
      controller.isInAsyncCall.value = false;
      return Get.dialog(AlertDialog(
        title: Text('cobrança alterada!'),
        content: Text('sua cobrança foi alterada com sucesso'),
        actions: [TextButton(onPressed: () => Get.back(), child: Text('ok'))],
      )).then((value) => Get.back());
    });
  }

  Future _datePicker() async {
    DateTime? picked = await showDatePicker(
        context: Get.context!,
        initialDate: controller.dpInitialDate!,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (picked != null) {
      Get.find<Charge111FormController>().setDataVencimento(picked);
    }
  }
}
