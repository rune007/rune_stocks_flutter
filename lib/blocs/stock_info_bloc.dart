import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import '../services/stock_repository.dart';
import '../models/stock_model.dart';
import './stock_info_event.dart';
import './stock_info_state.dart';

class StockInfoBloc extends Bloc<StockInfoEvent, StockInfoState> {
  final StockRepository stockRepository;

  StockInfoBloc({@required this.stockRepository})
      : assert(stockRepository != null);

  @override
  StockInfoState get initialState => StockInfoInitial();

  @override
  Stream<StockInfoState> mapEventToState(StockInfoEvent event) async* {
    if (event is StockInfoRequested) {
      yield* _mapStockInfoRequestedToState(event);
    } else if (event is StockInfoRefreshRequested) {
      yield* _mapStockInfoRefreshRequestedToState(event);
    }
  }

  Stream<StockInfoState> _mapStockInfoRequestedToState(
    StockInfoRequested event,
  ) async* {
    yield StockInfoLoadInProgress();

    try {
      final StockModel stockModel =
          await stockRepository.fetchStockInformation(event.tickerSymbol);
      yield StockInfoLoadSuccess(stockModel: stockModel);
    } catch (_) {
      yield StockInfoLoadFailure();
    }
  }

  Stream<StockInfoState> _mapStockInfoRefreshRequestedToState(
    StockInfoRefreshRequested event,
  ) async* {
    try {
      final StockModel stockModel =
          await stockRepository.fetchStockInformation(event.tickerSymbol);
      yield StockInfoLoadSuccess(stockModel: stockModel);
    } catch (_) {
      yield state;
    }
  }
}
