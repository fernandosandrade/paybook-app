import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:paybook_app/modules/auth/auth_controller.dart';
import 'package:paybook_app/modules/usuario/user_controller.dart';
import 'package:paybook_app/routes/app_pages.dart';
import 'package:paybook_app/themes/default_icons.dart';

import 'home_controller.dart';

abstract class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<HomeController>(
          init: Get.find<HomeController>(),
          builder: (_) {
            // return _.bookListObs.value.getBookList();
            return homeContent();
          }),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
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
              icon: Icon(DefaultIcons.MENU),
            ),
          ],
        ),
      ),
      floatingActionButton: Visibility(
        visible: isFABUsed(), // FAB only visible for books. homescreen of empty book not have FAB
        child: FloatingActionButton(
          child: Icon(Icons.add),
          // onPressed: () => Get.find<HomeController>().novaCobranca(),
          onPressed: fabAction,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  /// BottomAppBar header
  Widget _cabecalho() {
    return GetX<UserController>(
        init: Get.find<UserController>(),
        builder: (_) {
          return ListTile(
            //dense: true,
            title: Text('${_.user?.nome} ${_.user?.sobrenome}'),
            subtitle: Text("${_.user?.email}"),
            trailing: Icon(DefaultIcons.EDIT_1),
          );
        });
  }

  /// BottomAppBar booklist
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
                              title: Text('${_book?.nomeBook}'),
                              onTap: () => Get.find<HomeController>().changeBook(_book)),
                        ),
                      ],
                    ))
                .toList()),
        TextButton.icon(
            onPressed: () => Get.toNamed(AppRoutes.NOVO_BOOK), icon: Icon(DefaultIcons.ADD), label: Text('novo book'))
      ],
    );
  }

  /// BottonAppBar commands
  Widget _logout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(icon: Icon(DefaultIcons.CLOSE), onPressed: () => Get.back()),
        TextButton.icon(
            onPressed: () => Get.find<AuthController>().signOut(),
            icon: Icon(DefaultIcons.LOGOUT),
            label: Text('sair')),
      ],
    );
  }

  Widget homeContent();

  bool isFABUsed();

  Function fabAction();
}
