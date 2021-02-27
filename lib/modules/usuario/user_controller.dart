import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/user_model.dart';
import '../../data/repositories/users_repository.dart';
import '../auth/auth_controller.dart';

class UserController extends GetxController {
  AuthController _authController;
  IUsersRepository _usersRepository;
  Rx<UserModel> _userModel = UserModel().obs;

  UserController(
      {@required AuthController authController, @required IUsersRepository usersRepository}) {
    this._authController = authController;
    this._usersRepository = usersRepository;
  }

  onInit() {
    // faz o tratamento do usuario de acordo com a mudanca do
    ever(_authController.status,
        (status) => status == AuthStatus.LOGGED_IN ? _handleLoggedIn() : _handleLoggedOut());
  }

  UserModel get user => _userModel.value;

  Rx<UserModel> get rxUser => _userModel;

  set user(UserModel value) => this._userModel.value = value;

  void _handleLoggedIn() {
    log('user_controller loggedin ${_authController.user.email}');
    _usersRepository.getUser(email: _authController.user.email).then((repoUser) => repoUser != null
        ? user = repoUser
        : _usersRepository
            .save(UserModel(
              idUsuario: _authController.user.uid,
              email: _authController.user.email,
              nome: _authController.user.displayName
                  .split(' ')[0], // caso nome + sobrenome estejam juntos, pego apenas o nome
            ))
            .then((value) => user = value));
  }

  void _handleLoggedOut() {
    log('user_controller loggedout');
    _userModel.value = UserModel();
  }

  /*void clear() {
    _userModel.value = UserModel();
  }*/
}
