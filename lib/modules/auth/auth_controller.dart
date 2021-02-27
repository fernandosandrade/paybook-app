import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/user_model.dart';
import '../../data/repositories/users_repository.dart';
import '../../routes/app_pages.dart';
import '../../utils/enum_utils.dart';
import '../usuario/user_controller.dart';
import 'auth_service.dart';

enum AuthStatus { LOGGED_IN, NOT_LOGGED, UNDETERMINED }

extension AuthStatusExtension on AuthStatus {
  bool isEqual(String value) {
    return EnumUtils.getEnumFromString(AuthStatus.values, value) == this;
  }
}

class AuthController extends GetxController {
  IAuthService _authService;
  //IUsersRepository _usersRepository;
  Rx<FirebaseUser> _firebaseUser = Rx<FirebaseUser>();
  Rx<AuthStatus> status = AuthStatus.UNDETERMINED.obs;

  AuthController({@required IAuthService authService}) {
    this._authService = authService;
    //this._usersRepository = usersRepository;
    _firebaseUser.bindStream(_authService.onAuthStateChanged);
  }

  @override
  onReady() {
    //_firebaseUser.bindStream(_authService.onAuthStateChanged);
    ever(_firebaseUser, (_) => _ == null ? _handleNotLogged() : _handleLoggedIn());
  }

  void _handleNotLogged() {
    status.value = AuthStatus.NOT_LOGGED;
    log('${status.value}');
    Get.offAllNamed(AppRoutes.LOGIN);
  }

  void _handleLoggedIn() {
    status.value = AuthStatus.LOGGED_IN;
    log('${status.value}');
    Get.offAllNamed(AppRoutes.HOME);
  }

  FirebaseUser get user => _firebaseUser.value;

  void createUser(String name, String email, String password) async {
    try {
      AuthResult _authResult =
          await _authService.createUser(email: email.trim(), password: password);
      // cria o usuario na base de dados
      UserModel _user = UserModel(
        idUsuario: _authResult.user.uid,
        email: _authResult.user.email,
        nome: name.split(' ')[0], // caso nome + sobrenome estejam juntos, pego apenas o nome
      );
    } catch (e) {
      Get.snackbar(
        "Error creating Account",
        e.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// realiza o login com o google
  ///
  /// apos realizar login, busca o usuario na base de dados. encontrando o usuario, seta ele no [UserController], caso o usuario esteja logando pela primeira vez, salva no [UsersRepository] e seta ele no [UserController]
  Future loginWithGoogle() async {
    FirebaseUser user = await _authService.signInWithGoogle();
  }

  Future loginWithEmailPassword({String email, String password}) async {
    try {
      FirebaseUser user =
          await _authService.signInWithEmailPassword(email: email.trim(), password: password);
    } catch (e) {
      Get.snackbar(
        "Error signing in",
        e.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void signOut() async {
    try {
      await _authService.logout();
      //Get.find<UserController>().clear();
      Get.offAllNamed(AppRoutes.INITIAL);
    } catch (e) {
      Get.snackbar(
        "Error signing out",
        e.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
