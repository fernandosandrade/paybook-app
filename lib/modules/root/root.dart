import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../auth/auth_controller.dart';

class Root extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
