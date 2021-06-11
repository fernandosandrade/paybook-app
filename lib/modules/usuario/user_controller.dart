import 'dart:developer';

import 'package:get/get.dart';
import 'package:logging/logging.dart';
import 'package:paybook_app/services/enum_auth_status.dart';
import 'package:paybook_app/services/users_service.dart';

import '../../data/models/user_model.dart';
import '../auth/auth_controller.dart';

/// Controls the app user lifecicle
///
/// On loggin, searchs the user in repository, if exists, sets the _userModel. If not, saves the new user and set _userModel.
/// On loggout, clear the user
class UserController extends GetxController {
  final log = Logger('UserController');
  late AuthController _authController;
  late IUserService _userService;
  Rxn<UserModel> _userModel = Rxn<UserModel>();

  UserController({required AuthController authController, required IUserService userService}) {
    this._authController = authController;
    this._userService = userService;
  }

  onInit() {
    // internal loggin and logout treatment
    // deal with AuthController._userChangeHandle() changes
    ever(_authController.status,
        (status) => status == EnumAuthStatus.LOGGED_IN ? _handleLoggedIn() : _handleLoggedOut());
  }

  UserModel? get user => _userModel.value;

  set user(UserModel? value) => this._userModel.value = value;

  Rxn<UserModel> get rxUser => _userModel;

  /// handle users loggin from [AuthController]
  ///
  /// searchs the user in repository, if exists, sets the _userModel. If not, saves the new user and set _userModel
  void _handleLoggedIn() {
    var newUser = _authController.user;
    log.info('logged in user [${newUser.email}]');
    _userService.getUser(email: newUser.email!).then((repoUser) => repoUser != null
        ? user = repoUser
        : _userService
            .save(UserModel(
              (s) => s
                ..id = newUser.uid
                ..email = newUser.email
                ..nome = newUser.displayName!.split(' ')[0], // caso nome + sobrenome estejam juntos, pego apenas o nome
            ))
            .then((savedUser) => user = savedUser));
  }

  void _handleLoggedOut() {
    log.info('logged out user');
    _userModel.value = null;
  }

  /*void clear() {
    _userModel.value = UserModel();
  }*/
}
