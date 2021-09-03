import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logging/logging.dart';
import 'package:paybook_app/modules/root/root_bindings.dart';

import 'data/repository/repository_provider.dart';
import 'modules/root/root.dart';
import 'routes/app_pages.dart';
import 'themes/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then(
      (value) => log("firebase initialized. " + FirebaseFirestore.instance.app.options.projectId));
  RepositoryProvider.useEmulator();
  // FirebaseFirestore.instance.settings = const Settings(
  //   host: '10.0.2.2:9090',
  //   sslEnabled: false,
  //   persistenceEnabled: false,
  // );
  // await FirebaseAuth.instance.useEmulator('http://10.0.2.2:9099');
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) => print('[${record.level.name}] ${record.time.toUtc()}: '
      '${record.loggerName} => ${record.message}'));
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
