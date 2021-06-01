import 'package:flutter/widgets.dart';

/// Class to be implemented by pages who intent to be displayed at homescreen
abstract class HomeContentPage {
  /// returns the content of the widget, which will be displayed on the home screen
  Widget content();

  /// indicate if this pages will use the fab.
  /// if return false, the fab will be set as invisible.
  bool fabIsUsed();

  /// called on press of fab button
  void fabDelegate();
}
