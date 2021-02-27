import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../auth/auth_controller.dart';
import '../../usuario/user_controller.dart';


class NavigationDrawerWidget extends StatelessWidget {
  final String title;

  NavigationDrawerWidget({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find<UserController>();
    AuthController authController = Get.find<AuthController>();

    final drawerHeader = UserAccountsDrawerHeader(
      accountName: Text(userController.user.nome),
      accountEmail: Text(userController.user.email),
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
