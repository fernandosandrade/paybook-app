import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:paybook_app/data/models/book/book_101_model.dart';
import 'package:paybook_app/widgets/custom_widget.dart';

import 'book_101_form_controller.dart';

class Book101FormPage extends GetView<Book101FormController> {
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
                  ElevatedButton(
                      child: Text(controller.nomeBotao),
                      onPressed: () =>
                          controller.salvarBook().then((msgRetorno) => Get.dialog(AlertDialog(
                                title: Text('sucesso'),
                                content: Text(msgRetorno),
                                actions: [
                                  TextButton(
                                      onPressed: () => Get.back<String>(
                                          result: controller.bookModel!.id, closeOverlays: true),
                                      child: Text('ok'))
                                ],
                              ))))
                ])));
  }
}
