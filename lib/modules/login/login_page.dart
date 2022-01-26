import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:paybook_app/themes/default_icons.dart';

import '../auth/auth_controller.dart';
import 'login_controller.dart';

/*class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}*/

//class _LoginPageState extends State<LoginPage> {
class LoginPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  String? _email;
  String? _senha;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: GetX<LoginController>(
            assignId: true,
            builder: (_) {
              return ModalProgressHUD(
                child: _form(),
                inAsyncCall: _.isInAsyncCall.value,
                opacity: 0.5,
                progressIndicator: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }

  Widget _form() {
    return SingleChildScrollView(
      child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 30),
                  child: Text('Login', style: TextStyle(fontSize: 36)),
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[_loginGoogleButton(), _loginFacebooButton()]),
                Row(children: <Widget>[
                  Expanded(child: Divider(height: 80, endIndent: 10)),
                  Text('ou'),
                  Expanded(child: Divider(height: 80, indent: 10)),
                ]),
                SizedBox(
                  height: 150,
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        _emailInput(),
                        SizedBox(height: 10),
                        _passwordInput(),
                      ]),
                ),
                _loginButton(),
                ButtonBar(
                  alignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[_registerUserButton(), _forgotPasswordButton()],
                )
              ],
            ),
          )),
    );
  }

  Widget _loginGoogleButton() {
    var auth = Get.find<AuthController>();
    var loginController = Get.find<LoginController>();
    return TextButton(
      style: TextButton.styleFrom(
        primary: Colors.redAccent,
        padding: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(
            DefaultIcons.google,
            color: Colors.white,
          ),
          Text(
            "Login com Google",
            style: TextStyle(color: Colors.white),
          ),
          SizedBox()
        ],
      ),
      onPressed: () async {
        loginController.isInAsyncCall.value = true;
        //Get.snackbar('login google', 'login com google');
        await auth
            .loginWithGoogle()
            //.then((value) => Get.offNamed(AppRoutes.HOME))
            .then((value) => loginController.isInAsyncCall.value = false,
                onError: (error) =>
                    Get.snackbar('loggin erros', 'occurrer an erros while loggin with google'));
      },
    );
  }

  Widget _loginFacebooButton() {
    return TextButton(
        style: TextButton.styleFrom(
          primary: Color(0xff4267b2),
          padding: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(
              DefaultIcons.facebook,
              color: Colors.white,
            ),
            Text(
              "Login com Facebook",
              style: TextStyle(color: Colors.white),
            ),
            SizedBox()
          ],
        ),
        onPressed: () => Get.snackbar('login com facebook', 'login com facebook nao implementado'));
  }

  Widget _emailInput() {
    return TextFormField(
      maxLines: 1,
      enableSuggestions: true,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: new InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: 'email',
          prefixIcon: Icon(
            DefaultIcons.EMAIL_1,
            color: Colors.grey,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0))),
      validator: (value) => GetUtils.isEmail(value!) ? null : 'email invalido',
      onSaved: (value) => _email = value?.trim(),
      //),
    );
  }

  Widget _passwordInput() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "senha",
          prefixIcon: Icon(
            DefaultIcons.LOCK,
            color: Colors.grey,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0))),
      validator: (value) => GetUtils.isLengthGreaterOrEqual(value, 8)
          ? null
          : 'senha deve possuir no mínimo 8 caracteres',
      onSaved: (value) => _senha = value?.trim(),
    );
  }

  Widget _loginButton() {
    return TextButton(
      style: TextButton.styleFrom(
        primary: Colors.blueGrey,
        padding: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(width: 32),
          Text(
            "entrar",
            style: TextStyle(color: Colors.white),
          ),
          Icon(
            DefaultIcons.LOGIN,
            color: Colors.white,
            size: 32,
          ),
        ],
      ),
      onPressed: () async {
        final FormState form = formKey.currentState!;
        if (form.validate()) {
          form.save();
          Get.find<AuthController>().loginWithEmailPassword(
            email: _email!,
            password: _senha!,
          );
        }
      },
    );
  }

  Widget _registerUserButton() {
    return TextButton(
        child: Row(
          children: <Widget>[
            Icon(DefaultIcons.add_user, size: 14),
            Text(' novo usuario', style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic))
          ],
        ),
        onPressed: () =>
            Get.snackbar('registro de usuario', 'registro de usuario nao implementado'));
  }

  Widget _forgotPasswordButton() {
    return TextButton(
        child: Text('esqueceu sua senha?',
            style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic)),
        onPressed: () => Get.snackbar('recuperar senha', 'recuperacao de senha nao implementado'));
  }
}

/*import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:validators/validators.dart';

class CustomForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalKey key =  GlobalKey<FormState>();
    return GetX<LoginController>(
      assignId: true,
      builder: (_){
        return Form(
          key: key,
          child: Column(
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                onSaved: (value) => _.user.email = value,
                decoration: InputDecoration(labelText: 'Email'),
                enableSuggestions: true,
                maxLength: 32,
                style: TextStyle(fontSize: 20),
                validator: (value) {
                  if (!isEmail(value)) {
                    return 'Insira um email válido';
                  } else return null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                onSaved: (value) => _.user.password = value,
                decoration: InputDecoration(labelText: 'Senha'),
                enableSuggestions: true,
                obscureText: true,
                maxLength: 20,
                style: TextStyle(fontSize: 20),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Insira uma senha';
                  } else if (value.length < 5) {
                    return 'Insira uma senha maior';
                  } else return null;
                }
              ),
              RaisedButton(
                onPressed: (){
                  final FormState form = key.currentState;
                  form.validate()
                  ? form.save()
                  : print('erro ao logar');
                  print(_.user.email);
                  print(_.user.password);
                  _.login();
                },
                child: Text('OK'),
              )
            ],
          ),
        );
      }
    );
  }
}*/
