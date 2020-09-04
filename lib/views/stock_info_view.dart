import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/stock_info_bloc.dart';
import '../blocs/stock_info_event.dart';
import '../blocs/stock_info_state.dart';
import '../blocs/theme_bloc.dart';
import '../blocs/theme_event.dart';
import '../blocs/theme_state.dart';
import '../views/stock_selection_view.dart';
import '../views/gradient_container_partial_view.dart';
import '../views/last_updated_partial_view.dart';
import '../views/ticker_symbol_partial_view.dart';
import '../views/stock_price_partial_view.dart';
import '../views/bull_bear_condition_partial_view.dart';

class StockInfoView extends StatefulWidget {
  @override
  _StockInfoViewState createState() => _StockInfoViewState();
}

class _StockInfoViewState extends State<StockInfoView> {
  Completer<void> _refreshCompleter;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Stock'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final tickerSymbol = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StockSelectionView(),
                ),
              );
              if (tickerSymbol != null) {
                BlocProvider.of<StockInfoBloc>(context)
                    .add(StockInfoRequested(tickerSymbol: tickerSymbol));
              }
            },
          ),
        ],
      ),
      body: Center(
        child: BlocConsumer<StockInfoBloc, StockInfoState>(
          listener: (context, state) {
            if (state is StockInfoLoadSuccess) {
              BlocProvider.of<ThemeBloc>(context).add(
                BullBearConditionChanged(
                  bullBearCondition: state.stockModel.bullBearCondition,
                ),
              );
              _refreshCompleter?.complete();
              _refreshCompleter = Completer();
            }
          },
          builder: (context, state) {
            if (state is StockInfoLoadInProgress) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is StockInfoLoadSuccess) {
              final stockModel = state.stockModel;

              return BlocBuilder<ThemeBloc, ThemeState>(
                builder: (context, themeState) {
                  return GradientContainerPartialView(
                    materialColor: themeState.materialColor,
                    widget: RefreshIndicator(
                      onRefresh: () {
                        BlocProvider.of<StockInfoBloc>(context).add(
                          StockInfoRefreshRequested(
                            tickerSymbol: stockModel.tickerSymbol,
                          ),
                        );
                        return _refreshCompleter.future;
                      },
                      child: ListView(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                              top: 50.0,
                            ),
                            child: Center(
                              child: TickerSymbolPartialView(
                                tickerSymbol: stockModel.tickerSymbol,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(20.0),
                            child: StockPricePartialView(
                              currentPrice: stockModel.currentPrice,
                              highPriceDay: stockModel.highPriceDay,
                              lowPriceDay: stockModel.lowPriceDay,
                            ),
                          ),
                          Center(
                            child: LastUpdatedPartialView(
                              dateTime: stockModel.requestDateTime,
                            ),
                          ),
                          BullBearConditionPartialView(
                            bullBearCondition: stockModel.bullBearCondition,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }

            if (state is StockInfoLoadFailure) {
              return Text(
                'Something went wrong!',
                style: TextStyle(color: Colors.red),
              );
            }
            return Center(
              child: Text(
                'Please select a Stock Symbol',
              ),
            );
          },
        ),
      ),
    );
  }
}
