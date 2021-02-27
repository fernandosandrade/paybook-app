import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paybook_app/modules/root/root_bindings.dart';

import 'modules/root/root.dart';
import 'routes/app_pages.dart';
import 'themes/themes.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: AppRoutes.INITIAL,
    initialBinding: RootBinding(),
    home: Root(),
    getPages: AppPages.pages,
    theme: appThemeData,
    defaultTransition: Transition.fade,
  ));
}
