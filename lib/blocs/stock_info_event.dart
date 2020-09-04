import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

abstract class StockInfoEvent extends Equatable {
  const StockInfoEvent();
}

class StockInfoRequested extends StockInfoEvent {
  final String tickerSymbol;

  StockInfoRequested({@required this.tickerSymbol})
      : assert(tickerSymbol != null);

  @override
  List<Object> get props => [tickerSymbol];
}

class StockInfoRefreshRequested extends StockInfoEvent {
  final String tickerSymbol;

  StockInfoRefreshRequested({@required this.tickerSymbol})
      : assert(tickerSymbol != null);

  @override
  List<Object> get props => [tickerSymbol];
}
