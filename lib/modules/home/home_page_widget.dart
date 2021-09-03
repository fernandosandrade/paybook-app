import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:paybook_app/modules/auth/auth_controller.dart';
import 'package:paybook_app/modules/usuario/user_controller.dart';
import 'package:paybook_app/routes/app_pages.dart';
import 'package:paybook_app/themes/default_icons.dart';

import 'home_controller.dart';
import 'home_page_header_widget.dart';

class HomePageWidget extends StatelessWidget {
  final Widget headerWidget;

  final Widget list;

  final bool isFABUsed;

  final Function fabAction;

  HomePageWidget({
    required this.headerWidget,
    required this.list,
    required this.isFABUsed,
    required this.fabAction,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      bottomNavigationBar: _bottomAppBar(),
      floatingActionButton: _floatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  Widget _body() {
    return CustomScrollView(
      slivers: <Widget>[this.headerWidget, this.list],
    );
  }

  _bottomAppBar() {
    return BottomAppBar(
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
                        _bottomAppBarHeader(),
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
    );
  }

  /// BottomAppBar header
  Widget _bottomAppBarHeader() {
    return GetX<UserController>(
        init: Get.find<UserController>(),
        builder: (userController) {
          return ListTile(
            //dense: true,
            title: Text('${userController.user?.nome} ${userController.user?.sobrenome}'),
            subtitle: Text("${userController.user?.email}"),
            trailing: Icon(DefaultIcons.EDIT_1),
          );
        });
  }

  /// BottomAppBar booklist
  Widget _books() {
    return GetX<HomeController>(
        // init: Get.find<HomeController>(),
        builder: (homeController) {
      // var value = homeController.bookListStream.value;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
              children: homeController.bookListStream
                  .map((_book) => Row(
                        children: [
                          Expanded(
                            child: ListTile(
                                leading: Icon(DefaultIcons.BOOK_1, color: Colors.black),
                                title: Text('${_book!.name}'),
                                onTap: () => homeController.changeBook(_book!.id)),
                          ),
                        ],
                      ))
                  .toList()),
          TextButton.icon(
              onPressed: () => homeController.newBook(),
              icon: Icon(DefaultIcons.ADD),
              label: Text('novo book'))
        ],
      );
    });
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

  _floatingActionButton() {
    return Visibility(
      visible: isFABUsed, // FAB only visible for books. homescreen of empty book not have FAB
      child: FloatingActionButton(
        child: Icon(Icons.add),
        // onPressed: () => Get.find<HomeController>().novaCobranca(),
        onPressed: () => fabAction(),
      ),
    );
  }
}
