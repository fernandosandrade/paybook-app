import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:convert/convert.dart';

import '../../data/models/destinatario.dart';
import '../../utils/phone_number_input_formatter.dart';

class DestinatarioController extends GetxController {
  final GlobalKey _formKey = GlobalKey<FormState>();
  //final phoneMask = MaskTextInputFormatter(mask: '###-###-###', filter: {'#': RegExp(r'[0-9]')});
  final phoneMask = PhoneNumberInputFormatter();
  final Destinatario destinatario = Destinatario();

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
      Contact contact = await ContactsService.openDeviceContactPicker();
      nomeController.text = contact.displayName;
      emailController.text = contact.emails.isNotEmpty ? contact.emails.first.value : '';

      //telefoneController.text =
      //    phoneMask.maskText(contact.phones.isNotEmpty ? contact.phones.first.value : '');
      telefoneController.text = contact.phones.isNotEmpty
          ? contact.phones.first.value.replaceAll(new RegExp('[^0-9]'), "")
          : '';
    } catch (e) {
      print(e.toString());
    }
  }

  salvar() {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      this.destinatario.nome = nomeController.text;
      this.destinatario.telefone = telefoneController.text;
      this.destinatario.email = emailController.text;
      Get.back(result: this.destinatario);
    } else {
      print('erro ao logar');
    }
  }

  _initFormAlterar() {
    this.nomeController.text = Get.parameters['nome'];
    this.telefoneController.text = Get.parameters['telefone'];
    this.emailController.text = Get.parameters['email'];
  }

  _initFormIncluir() {}
}
