import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:paybook_app/themes/default_icons.dart';

import 'destinatario_controller.dart';

class DestinatarioPage extends GetView<DestinatarioController> {
  // String? _nome;
  // String? _telefone;
  // String? _email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('destinatário')),
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
      // onSaved: (value) => nome = value,
      decoration: InputDecoration(icon: Icon(DefaultIcons.USER_1), labelText: 'nome'),
      enableSuggestions: true,
      //maxLength: 32,
      //style: TextStyle(fontSize: 20),
      validator: (value) {
        if (!GetUtils.isUsername(GetUtils.removeAllWhitespace(value!))) {
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
      // onSaved: (value) => telefone = value,
      decoration: InputDecoration(
        icon: Icon(DefaultIcons.PHONE_1),
        labelText: "telefone",
        //hintText: '(51) 123-456-789',
      ),
      enableSuggestions: true,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      //style: TextStyle(fontSize: 20),
      validator: (value) {
        if (GetUtils.isPhoneNumber(value!) || GetUtils.isPhoneNumber('(00)$value')) {
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
      // onSaved: (value) => email = value,
      decoration: InputDecoration(icon: Icon(DefaultIcons.EMAIL_1), labelText: 'email'),
      enableSuggestions: true,
      //maxLength: 32,
      //style: TextStyle(fontSize: 20),
      validator: (value) {
        if (!GetUtils.isEmail(value!)) {
          return 'Insira um email válido';
        } else
          return null;
      },
    );
  }

  _botoes() {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      ElevatedButton(child: Text('ver contatos'), onPressed: () => controller.pickContact()),
      ElevatedButton(child: Text('ok'), onPressed: () => controller.salvar())
    ]);
  }
}
