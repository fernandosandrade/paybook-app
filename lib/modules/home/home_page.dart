import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';
import '../../themes/default_icons.dart';
import '../auth/auth_controller.dart';
import '../usuario/user_controller.dart';
import 'home_controller.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<HomeController>(
          init: Get.find<HomeController>(),
          builder: (_) {
            return _.bookListObs.value.getBookList();
          }),
      bottomNavigationBar: new BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Feather.menu),
              onPressed: () {
                Get.bottomSheet(
                    Container(
                      child: Wrap(
                        children: <Widget>[
                          _cabecalho(),
                          Divider(),
                          _books(),
                          Divider(),
                          _logout(),
                        ],
                      ),
                    ),
                    backgroundColor: Colors.white);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Get.find<HomeController>().novaCobranca(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  Widget _cabecalho() {
    return GetX<UserController>(
        init: Get.find<UserController>(),
        builder: (_) {
          return ListTile(
            //dense: true,
            title: Text('${_.user.nome} ${_.user.sobrenome}'),
            subtitle: Text("${_.user.email}"),
            trailing: Icon(DefaultIcons.ICONE_EDITAR_2),
          );
        });
  }

  Widget _books() {
    var value = Get.find<HomeController>().bookList.value;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
            children: value
                .map((_book) => Row(
                      children: [
                        Expanded(
                          child: ListTile(
                              leading: Icon(DefaultIcons.BOOK_1, color: Colors.black),
                              title: Text('${_book.nomeBook}'),
                              onTap: () => Get.find<HomeController>().changeBook(_book.idBook)),
                        ),
                      ],
                    ))
                .toList()),
        TextButton.icon(
            onPressed: () => Get.toNamed(AppRoutes.NOVO_BOOK), icon: Icon(Ionicons.md_add), label: Text('novo book'))
      ],
    );
  }

  Widget _logout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(icon: Icon(Ionicons.md_close), onPressed: () => Get.back()),
        TextButton.icon(
            onPressed: () => Get.find<AuthController>().signOut(), icon: Icon(Ionicons.md_exit), label: Text('sair')),
      ],
    );
  }
}
