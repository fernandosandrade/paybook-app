import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:paybook_app/modules/auth/enum_auth_status.dart';

import '../../data/models/user_model.dart';
import '../../data/repositories/users_repository.dart';
import '../../routes/app_pages.dart';
import '../usuario/user_controller.dart';
import 'auth_service.dart';

class AuthController extends GetxController {
  final IAuthService authService;
  //IUsersRepository _usersRepository;
  Rx<FirebaseUser> _firebaseUser = Rx<FirebaseUser>();
  Rx<EnumAuthStatus> status = EnumAuthStatus.UNDETERMINED.obs;

  AuthController({required this.authService}) {
    // this._authService = authService;
    //this._usersRepository = usersRepository;
    _firebaseUser.bindStream(authService.onAuthStateChanged);
  }

  @override
  onReady() {
    //_firebaseUser.bindStream(_authService.onAuthStateChanged);
    ever(_firebaseUser, (firebaseUser) => firebaseUser == null ? _handleNotLogged() : _handleLoggedIn());
  }

  void _handleNotLogged() {
    status.value = EnumAuthStatus.NOT_LOGGED;
    log('${status.value}');
    Get.offAllNamed(AppRoutes.LOGIN);
  }

  void _handleLoggedIn() {
    status.value = EnumAuthStatus.LOGGED_IN;
    log('${status.value}');
    Get.offAllNamed(AppRoutes.HOME);
  }

  FirebaseUser get user => _firebaseUser.value;

  void createUser(String name, String email, String password) async {
    try {
      AuthResult _authResult = await authService.createUser(email: email.trim(), password: password);
      // cria o usuario na base de dados
      UserModel _user = UserModel(
        idUsuario: _authResult.user.uid,
        email: _authResult.user.email,
        nome: name.split(' ')[0], // caso nome + sobrenome estejam juntos, pego apenas o nome
      );
    } catch (e) {
      Get.snackbar(
        "Error creating Account",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// realiza o login com o google
  ///
  /// apos realizar login, busca o usuario na base de dados. encontrando o usuario, seta ele no [UserController], caso o usuario esteja logando pela primeira vez, salva no [UsersRepository] e seta ele no [UserController]
  Future loginWithGoogle() async {
    FirebaseUser user = await authService.signInWithGoogle();
  }

  Future loginWithEmailPassword({required String email, required String password}) async {
    try {
      FirebaseUser user = await authService.signInWithEmailPassword(email: email.trim(), password: password);
    } catch (e) {
      Get.snackbar(
        "Error signing in",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void signOut() async {
    try {
      await authService.logout();
      //Get.find<UserController>().clear();
      Get.offAllNamed(AppRoutes.INITIAL);
    } catch (e) {
      Get.snackbar(
        "Error signing out",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
