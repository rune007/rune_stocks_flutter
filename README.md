# rune_stocks_flutter
Flutter application consuming Finnhub Stock API, allowing you to look up stock prices.

Simple app demonstrating the use of the BLoC design pattern. To manage state the app uses BlocProvider and Streams. Some of the packages that the app is using are slightly outdated. The app will need to be refactored if you update the packages. But if you do not update the packages, you can run the app.

In order to run the application, you need to get your own free API Key from Finnhub Stock API, and paste it into the variable apiKey in the file: lib/services/stock_api_client.dart. The application gets its data from Finnhub Stock API - https://finnhub.io/

The application allows the user to type in a stock symbol, and retrieve the current stock price from an API. If the stock price is larger than the previous trading day, the UI is colored green and the image of a bull is displayed in the UI. If the stock price is less than the previous trading day, the UI is colored red and the image of a bear
is displayed in the UI. In case of that the stock price hasn't moved the UI is colored grey, and an image of a balance is shown.

The application is controlled by 2 blocs:

StockInfoBloc
 - This bloc is responsible for controlling requests in the form of StockInfoEvents from the UI, requiring data on various stock ticker symbols. The bloc responds in the form of StockInfoStates, which in turn is picked up by the UI.

ThemeBloc
 - This bloc controls the appeareance of the UI, based on the stocks previous price and the stocks current price, the UI is either painted red or green or neutral. The UI is controlled by states of theme.

![ui_bull_state_stock](/screen_shots/ui_bull_state_stock.png)
![ui_bear_state_stock](/screen_shots/ui_bear_state_stock.png)
![look_up_stock_symbol](/screen_shots/look_up_stock_symbol.png)
![look_up_stock_symbol_dark](/screen_shots/look_up_stock_symbol_dark.png)
