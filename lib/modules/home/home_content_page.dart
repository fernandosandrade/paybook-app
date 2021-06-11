import 'package:flutter/widgets.dart';

/// Class to be implemented by pages who intent to be displayed at homescreen
abstract class HomeContentPage {
  /// indicate if this pages will use the fab.
  /// if return false, the fab will be set as invisible.
  bool isFABUsed();

  /// called on press of fab button
  void fabAction();
}
