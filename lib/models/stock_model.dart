import 'package:equatable/equatable.dart';

enum BullBearCondition {
  bull,
  bear,
  neutral,
}

class StockModel extends Equatable {
  final String tickerSymbol;
  final double currentPrice;
  final double highPriceDay;
  final double lowPriceDay;
  final double openPriceDay;
  final double previousClosePrice;
  final BullBearCondition bullBearCondition;
  final int requestUnixTimestampSeconds;
  final DateTime requestDateTime;

  StockModel({
    this.tickerSymbol,
    this.currentPrice,
    this.highPriceDay,
    this.lowPriceDay,
    this.openPriceDay,
    this.previousClosePrice,
    this.bullBearCondition,
    this.requestUnixTimestampSeconds,
    this.requestDateTime,
  });

  @override
  List<Object> get props => [
        tickerSymbol,
        currentPrice,
        highPriceDay,
        lowPriceDay,
        openPriceDay,
        previousClosePrice,
        bullBearCondition,
        requestUnixTimestampSeconds,
        requestDateTime,
      ];

  static StockModel generateModel(String tickerSymbol, dynamic json) {
    return StockModel(
      tickerSymbol: tickerSymbol,
      currentPrice: json['c'].toDouble() as double,
      highPriceDay: json['h'].toDouble() as double,
      lowPriceDay: json['l'].toDouble() as double,
      openPriceDay: json['o'].toDouble() as double,
      previousClosePrice: json['pc'].toDouble() as double,
      bullBearCondition: _mapBullBearStockCondition(
          json['c'].toDouble() as double, json['pc'].toDouble() as double),
      requestUnixTimestampSeconds: json['t'].toInt() as int,
      requestDateTime: _convertUnixTimestampSecondsToDateTime(
          unixTimestampSeconds: json['t'].toInt() as int),
    );
  }

  static DateTime _convertUnixTimestampSecondsToDateTime(
      {int unixTimestampSeconds}) {
    return new DateTime.fromMillisecondsSinceEpoch(unixTimestampSeconds * 1000);
  }

  static BullBearCondition _mapBullBearStockCondition(
      double currentPrice, double previousClosePrice) {
    BullBearCondition stockCondition;
    if (currentPrice > previousClosePrice) {
      stockCondition = BullBearCondition.bull;
    } else if (currentPrice < previousClosePrice) {
      stockCondition = BullBearCondition.bear;
    } else {
      stockCondition = BullBearCondition.neutral;
    }
    return stockCondition;
  }
}
