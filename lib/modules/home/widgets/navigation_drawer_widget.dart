import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paybook_app/globals/default_messagem.dart';
import '../../auth/auth_controller.dart';
import '../../usuario/user_controller.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final String title;

  NavigationDrawerWidget({required Key key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find<UserController>();
    AuthController authController = Get.find<AuthController>();

    var userName = userController.user != null ? userController.user!.nome : DefaultMessagem.NOT_AVALIABLE;
    var userEmail = userController.user != null ? userController.user!.email : DefaultMessagem.NOT_AVALIABLE;
    final drawerHeader = UserAccountsDrawerHeader(
      accountName: Text(userName),
      accountEmail: Text(userEmail),
      currentAccountPicture: CircleAvatar(
        child: FlutterLogo(size: 42),
        backgroundColor: Colors.white,
      ),
    );

    final drawerItems = ListView(
      children: <Widget>[
        drawerHeader,
        ListTile(
          title: Text('configurações'),
          onTap: () => Navigator.of(context).push(_NovaPagina(1)),
        ),
        ListTile(
          title: Text('ajuda'),
          onTap: () => Navigator.of(context).push(_NovaPagina(2)),
        ),
        Divider(),
        ListTile(
          title: Text('sair'),
          onTap: () => authController.signOut(),
        )
      ],
    );

    return Drawer(child: drawerItems);
  }
}

class _NovaPagina extends MaterialPageRoute<Null> {
  _NovaPagina(int id)
      : super(builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('pagina $id'),
              elevation: 1.0,
            ),
            body: Center(
              child: Text('pagina $id'),
            ),
          );
        });
}
