import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logging/logging.dart';

import '../../data/models/destinatario.dart';
import '../../utils/phone_number_input_formatter.dart';

class DestinatarioController extends GetxController {
  final log = Logger('DestinatarioController');
  final _formKey = GlobalKey<FormState>();

  final phoneMask = PhoneNumberInputFormatter();
  Destinatario? destinatario;

  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final telefoneController = TextEditingController();

  @override
  onInit() {
    Get.parameters.isNotEmpty ? _initFormAlterar() : _initFormIncluir();
  }

  GlobalKey get formKey => this._formKey;

  Future<void> pickContact() async {
    try {
      Contact? contact = (await ContactsService.openDeviceContactPicker());
      if (contact != null) {
        nomeController.text = (contact.displayName != null ? contact.displayName : "")!;
        emailController.text = (contact.emails!.isNotEmpty ? contact.emails!.first.value : '')!;
        telefoneController.text = contact.phones!.isNotEmpty
            ? contact.phones!.first.value!.replaceAll(new RegExp('[^0-9]'), "")
            : '';
      }
    } catch (e) {
      print(e.toString());
    }
  }

  salvar() {
    final FormState form = _formKey.currentState!;
    if (form.validate()) {
      form.save();
      this.destinatario = Destinatario((s) => s
        ..nome = nomeController.text
        ..email = emailController.text
        ..telefone = telefoneController.text);
      Get.back(result: this.destinatario);
    } else {
      log.warning('invalid form');
    }
  }

  _initFormAlterar() {
    this.nomeController.text = (Get.parameters.containsKey('nome') ? Get.parameters['nome'] : '')!;
    this.telefoneController.text =
        (Get.parameters.containsKey('telefone') ? Get.parameters['telefone'] : '')!;
    this.emailController.text =
        (Get.parameters.containsKey('email') ? Get.parameters['email'] : '')!;
  }

  _initFormIncluir() {}
}
