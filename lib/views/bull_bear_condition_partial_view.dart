import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../models/stock_model.dart';

class BullBearConditionPartialView extends StatelessWidget {
  final BullBearCondition bullBearCondition;

  BullBearConditionPartialView({Key key, @required this.bullBearCondition})
      : assert(bullBearCondition != null),
        super(key: key);

  @override
  Widget build(BuildContext context) =>
      _mapBullBearConditionToImage(bullBearCondition);

  Image _mapBullBearConditionToImage(BullBearCondition bullBearCondition) {
    Image image;
    switch (bullBearCondition) {
      case BullBearCondition.neutral:
        image = Image.asset('assets/neutral_160.png');
        break;
      case BullBearCondition.bull:
        image = Image.asset('assets/bull_160.png');
        break;
      case BullBearCondition.bear:
        image = Image.asset('assets/bear_160.png');
        break;
    }
    return image;
  }
}
