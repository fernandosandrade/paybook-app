import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../../../../globals/enum_form_action.dart';
import '../../../../themes/app_text_style.dart';
import '../../../../themes/default_icons.dart';
import '../../../../utils/currency_pt_br_input_formatter.dart';
import '../../../../widgets/custom_widget.dart';
import 'cobranca_simples_form_controller.dart';

class CobrancaSimplesFormPage extends GetView<CobrancaSimplesFormController> {
  final _dateFormat = DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    return GetX<CobrancaSimplesFormController>(builder: (_) {
      return Scaffold(
        appBar: CustomWidget.appbar(titulo: _.tituloForm.value),
        body: ModalProgressHUD(
          child: _.isInAsyncCall.value ? Center() : _form(),
          inAsyncCall: _.isInAsyncCall.value,
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
                WhitelistingTextInputFormatter.digitsOnly,
                CurrencyPtBrInputFormatter(maxDigits: 8),
              ],
              onSaved: (String val) =>
                  controller.valor = double.parse(val.replaceAll(new RegExp('[^0-9]'), "")) / 100),
        ),
      ]),
    );
  }

  inputDestinatario() {
    return GestureDetector(
        onTap: () => controller.editarDestinatario(),
        child: GetX<CobrancaSimplesFormController>(builder: (_) {
          return _.destinatario.value.nome == null
              ? Container(
                  child: FlatButton.icon(
                      label: Text(
                        'destinatário',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      icon: Icon(
                        DefaultIcons.CONTACT_1,
                        color: Colors.black,
                      ),
                      onPressed: null))
              : Container(
                  child: InputDecorator(
                      decoration:
                          InputDecoration(labelText: 'destinatario', border: InputBorder.none),
                      child: InputChip(
                          avatar: CircleAvatar(
                            //backgroundImage: MemoryImage(_.destinatario.value.avatar),
                            child: Text('${_.destinatario.value.nome.substring(0, 1)}'),
                          ),
                          label: Text('${_.destinatario.value.nome}'),
                          onPressed: () => controller.editarDestinatario())));
        }));
  }

  inputVencimento() {
    return GetX<CobrancaSimplesFormController>(builder: (_) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
          _editorVencimento(),
        ],
      );
    });
  }

  _editorVencimento() {
    return GetX<CobrancaSimplesFormController>(builder: (_) {
      if (_.formAction.value == EnumFormAction.INCLUIR) {
        return Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ToggleButtons(
                  renderBorder: false,
                  children: _.vencimentos.values.toList(),
                  onPressed: (index) => _.changeToggleVencimento(index),
                  isSelected: _.toggleVencimentos.value),
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
                  icon: Icon(Icons.remove), onPressed: () => _.changeDataVencimento(removeDias: 1)),
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
        );
      }
    });
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
    return GetX<CobrancaSimplesFormController>(builder: (_) {
      if (_.formAction.value == EnumFormAction.INCLUIR) {
        return botaoIncluirCobranca();
      } else if (_.formAction.value == EnumFormAction.ALTERAR) {
        return botaoAlterarCobranca();
      } else
        throw Exception('nao foi possivel identificar a acao do form');
    });
  }

  botaoIncluirCobranca() {
    return RaisedButton(
      child: new Text(
        'incluir cobrança',
        style: new TextStyle(color: Colors.white),
      ),
      onPressed: incluirCobranca,
      color: Colors.blue,
    );
  }

  botaoAlterarCobranca() {
    return RaisedButton(
      child: new Text(
        'alterar cobrança',
        style: new TextStyle(color: Colors.white),
      ),
      onPressed: alterarCobranca,
      color: Colors.blue,
    );
  }

  void incluirCobranca() {
    final controller = Get.find<CobrancaSimplesFormController>();
    controller.formKey.currentState.save();
    controller.salvarCobranca().then((value) => Get.dialog(AlertDialog(
          title: Text('cobrança registrada!'),
          content: Text('sua nova cobrança foi registrada com sucesso'),
          actions: [FlatButton(onPressed: () => Get.back(), child: Text('ok'))],
        )).then((value) => Get.back()));
  }

  void alterarCobranca() {
    final controller = Get.find<CobrancaSimplesFormController>();
    controller.formKey.currentState.save();
    controller.salvarCobranca().then((value) => Get.dialog(AlertDialog(
          title: Text('cobrança alterada!'),
          content: Text('sua cobrança foi alterada com sucesso'),
          actions: [FlatButton(onPressed: () => Get.back(), child: Text('ok'))],
        )).then((value) => Get.back()));
  }

  Future _datePicker() async {
    DateTime picked = await showDatePicker(
        context: Get.context,
        initialDate: Get.find<CobrancaSimplesFormController>().dpInitialDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (picked != null) {
      Get.find<CobrancaSimplesFormController>().setDataVencimento(picked);
    }
  }
}
