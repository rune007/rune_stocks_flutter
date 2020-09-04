import 'package:flutter/material.dart';

class StockSelectionView extends StatefulWidget {
  @override
  _StockSelectionViewState createState() => _StockSelectionViewState();
}

class _StockSelectionViewState extends State<StockSelectionView> {
  final TextEditingController _stockNameTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ticker Symbol'),
      ),
      body: Form(
        child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: TextFormField(
                  controller: _stockNameTextEditingController,
                  decoration: InputDecoration(
                      labelText: 'Ticker Symbol',
                      hintText: 'Please Input Stock Name!'),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.pop(context, _stockNameTextEditingController.text);
              },
            ),
          ],
        ),
      ),
    );
  }
}
