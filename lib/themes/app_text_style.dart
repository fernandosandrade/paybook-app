import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class AppTextStyle {
  static final TextStyle grande = Theme.of(Get.context).textTheme.headline3;

  static final TextStyle medio = Theme.of(Get.context).textTheme.headline5;

  static final TextStyle normalDestacado = Theme.of(Get.context).textTheme.bodyText1;

  static final TextStyle auxiliar = Theme.of(Get.context).textTheme.caption;

  static final TextStyle subtitulo = Theme.of(Get.context).textTheme.subtitle1;
}
