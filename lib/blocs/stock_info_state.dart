import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

import '../models/stock_model.dart';

abstract class StockInfoState extends Equatable {
  const StockInfoState();

  @override
  List<Object> get props => [];
}

class StockInfoInitial extends StockInfoState {}

class StockInfoLoadInProgress extends StockInfoState {}

class StockInfoLoadSuccess extends StockInfoState {
  final StockModel stockModel;

  StockInfoLoadSuccess({@required this.stockModel})
      : assert(stockModel != null);

  @override
  List<Object> get props => [stockModel];
}

class StockInfoLoadFailure extends StockInfoState {}
