import 'dart:async';
import 'package:meta/meta.dart';

import '../services/stock_api_client.dart';
import '../models/stock_model.dart';

class StockRepository {
  final StockApiClient stockApiClient;

  StockRepository({@required this.stockApiClient})
      : assert(stockApiClient != null);

  Future<StockModel> fetchStockInformation(String stockSymbol) async {
    return stockApiClient.fetchStockInformation(stockSymbol);
  }
}
