import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../themes/default_icons.dart';
import '../../utils/phone_number_input_formatter.dart';
import '../../widgets/custom_widget.dart';
import 'destinatario_controller.dart';

class DestinatarioPage extends GetView<DestinatarioController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomWidget.appbar(titulo: 'destinatário'),
      body: _form(),
    );
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _inputNome(),
              _inputTelefone(),
              _inputEmail(),
              _botoes(),
            ],
          ),
        ),
      ),
    );
  }

  _inputNome() {
    return TextFormField(
      controller: controller.nomeController,
      keyboardType: TextInputType.name,
      onSaved: (value) => controller.destinatario.nome = value,
      decoration: InputDecoration(icon: Icon(DefaultIcons.USUARIO_1), labelText: 'nome'),
      enableSuggestions: true,
      //maxLength: 32,
      //style: TextStyle(fontSize: 20),
      validator: (value) {
        if (!GetUtils.isUsername(GetUtils.removeAllWhitespace(value))) {
          return 'Insira um nome válido';
        } else
          return null;
      },
    );
  }

  _inputTelefone() {
    return TextFormField(
      controller: controller.telefoneController,
      keyboardType: TextInputType.phone,
      onSaved: (value) => controller.destinatario.telefone = value,
      decoration: InputDecoration(
        icon: Icon(DefaultIcons.TELEFONE_1),
        labelText: "telefone",
        //hintText: '(51) 123-456-789',
      ),
      enableSuggestions: true,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      //style: TextStyle(fontSize: 20),
      validator: (value) {
        if (GetUtils.isPhoneNumber(value) || GetUtils.isPhoneNumber('(00)$value')) {
          return null;
        } else
          return 'Insira um telefone válido';
      },
    );
  }

  _inputEmail() {
    return TextFormField(
      controller: controller.emailController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) => controller.destinatario.email = value,
      decoration: InputDecoration(icon: Icon(DefaultIcons.EMAIL_1), labelText: 'email'),
      enableSuggestions: true,
      //maxLength: 32,
      //style: TextStyle(fontSize: 20),
      validator: (value) {
        if (!GetUtils.isEmail(value)) {
          return 'Insira um email válido';
        } else
          return null;
      },
    );
  }

  _botoes() {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      RaisedButton(child: Text('ver contatos'), onPressed: () => controller.pickContact()),
      RaisedButton(child: Text('ok'), onPressed: () => controller.salvar())
    ]);
  }
}
