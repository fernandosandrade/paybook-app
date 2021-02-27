import 'package:flutter/material.dart';

class FabNovaCobrancaWidget extends StatefulWidget {
  @override
  State createState() => new _FabNovaCobrancaWidgetState();
}

class _FabNovaCobrancaWidgetState extends State<FabNovaCobrancaWidget>
    with TickerProviderStateMixin {
  AnimationController _controller;

  static const List<IconData> icons = const [Icons.star, Icons.attach_money];

  @override
  void initState() {
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).cardColor;
    Color foregroundColor = Theme.of(context).accentColor;
    return new Column(
      mainAxisSize: MainAxisSize.min,
      children: new List.generate(icons.length, (int index) {
        Widget child = new Container(
          height: 70.0,
          width: 56.0,
          alignment: FractionalOffset.topCenter,
          child: new ScaleTransition(
            scale: new CurvedAnimation(
              parent: _controller,
              curve: new Interval(0.0, 1.0 - index / icons.length / 2.0, curve: Curves.easeOut),
            ),
            child: new FloatingActionButton(
                heroTag: null,
                backgroundColor: backgroundColor,
                mini: true,
                child: new Icon(icons[index], color: foregroundColor),
                onPressed: () {
                  icons[index] == Icons.attach_money ? _novaCobranca() : _novaCobrancaEspecial();
                  _controller.reverse();
                }),
          ),
        );
        return child;
      }).toList()
        ..add(
          new FloatingActionButton(
            child: AnimatedIcon(
              icon: AnimatedIcons.menu_close,
              progress: _controller,
            ),
            onPressed: () {
              if (_controller.isDismissed) {
                _controller.forward();
              } else {
                _controller.reverse();
              }
            },
          ),
        ),
    );
  }

  void _novaCobranca() {
    print('nova cobranca');
    //Modular.to.pushNamed("/cobranca/cobranca_simples");
  }

  void _novaCobrancaEspecial() {
    print('nova cobranca especial');
  }
}
