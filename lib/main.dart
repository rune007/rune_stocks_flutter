import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'simple_bloc_delegate.dart';

import './services/stock_api_client.dart';
import './services/stock_repository.dart';
import './blocs/stock_info_bloc.dart';
import './blocs/theme_bloc.dart';
import './blocs/theme_state.dart';
import './views/stock_info_view.dart';

void main() {
  final StockRepository stockRepository = StockRepository(
    stockApiClient: StockApiClient(
      httpClient: http.Client(),
    ),
  );
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeBloc(),
        ),
      ],
      child: App(stockRepository: stockRepository),
    ),
  );
}

class App extends StatelessWidget {
  final StockRepository stockRepository;

  App({Key key, @required this.stockRepository})
      : assert(stockRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return MaterialApp(
          title: 'Hansen Flutter Stock',
          theme: themeState.themeData,
          home: BlocProvider(
            create: (context) => StockInfoBloc(
              stockRepository: stockRepository,
            ),
            child: StockInfoView(),
          ),
        );
      },
    );
  }
}
