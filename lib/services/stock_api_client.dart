import 'dart:convert';
import 'dart:async';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import '../models/stock_model.dart';

class StockApiClient {
  static const baseUrl = 'https://finnhub.io';
  static const apiKey = 'PUT_YOUR_FINNHUB_API_KEY_HERE';
  final http.Client httpClient;

  StockApiClient({@required this.httpClient}) : assert(httpClient != null);

  Future<StockModel> fetchStockInformation(String stockSymbol) async {
    var searchString = _trimAndUppercaseString(stockSymbol);
    final apiRequestUrl =
        '$baseUrl/api/v1/quote?symbol=$searchString&token=$apiKey';
    final apiResponse = await this.httpClient.get(apiRequestUrl);
    if (apiResponse.statusCode != 200) {
      throw Exception('Error in StockApiClient.fetchStockInformation() ' +
          apiResponse.toString());
    }
    final apiResponseJson = jsonDecode(apiResponse.body);
    return StockModel.generateModel(searchString, apiResponseJson);
  }

  String _trimAndUppercaseString(String inputString) {
    String resultString = '';
    if (inputString != null) {
      resultString = inputString.trim().toUpperCase();
    }
    return resultString;
  }
}

// Example Request/Response.
//https://finnhub.io/api/v1/quote?symbol=TSLA&token=PUT_YOUR_FINNHUB_API_KEY_HERE'
//https://finnhub.io/api/v1/quote?symbol=AAPL&token=PUT_YOUR_FINNHUB_API_KEY_HERE'
//
//{
//c: 1119.63,
//h: 1135.33,
//l: 1080.5,
//o: 1083,
//pc: 1079.81,
//t: 1593637402
//}
