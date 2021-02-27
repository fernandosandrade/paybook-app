import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:paybook_app/widgets/custom_widget.dart';

import 'book_simples_form_controller.dart';

class BookSimplesFormPage extends GetView<BookSimplesFormController> {
  Widget build(BuildContext context) {
    return GetX<BookSimplesFormController>(builder: (_) {
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
    return Container(
        margin: EdgeInsets.all(20.0),
        child: Form(
            key: controller.formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  TextFormField(
                    controller: controller.nomeBookTextController,
                    decoration: InputDecoration(labelText: 'nome da lista'),
                  ),
                  RaisedButton(
                      child: Obx(() => Text(controller.nomeBotao.value)),
                      onPressed: () => controller
                          .salvarBook()
                          .then((msgRetorno) => Get.dialog(AlertDialog(
                                title: Text('sucesso'),
                                content: Text(msgRetorno),
                                actions: [
                                  FlatButton(onPressed: () => Get.back(), child: Text('ok'))
                                ],
                              )))
                          .then((value) => Get.until((route) => Get.currentRoute == '/home')))
                ])));
  }
}
