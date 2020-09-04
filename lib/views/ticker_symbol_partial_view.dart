import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class TickerSymbolPartialView extends StatelessWidget {
  final String tickerSymbol;

  TickerSymbolPartialView({Key key, @required this.tickerSymbol})
      : assert(tickerSymbol != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      tickerSymbol,
      style: TextStyle(
        fontSize: 50,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}
