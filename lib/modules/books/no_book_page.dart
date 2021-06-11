import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:paybook_app/modules/home/home_content_page.dart';
import 'package:paybook_app/modules/home/home_page_header_widget.dart';
import 'package:paybook_app/modules/home/home_page_widget.dart';

class NoBookPage extends StatelessWidget implements HomeContentPage {
  @override
  Widget build(BuildContext context) {
    return HomePageWidget(headerWidget: _header(), list: _list(), isFABUsed: isFABUsed(), fabAction: fabAction);
  }

  Widget _header() {
    return SliverToBoxAdapter(
      child: Center(
        child: Text(''),
      ),
    );
  }

  Widget _list() {
    return SliverToBoxAdapter(
      child: Center(
        child: Text('no book'),
      ),
    );
  }

  @override
  void fabAction() {}

  @override
  bool isFABUsed() {
    return false;
  }
}
