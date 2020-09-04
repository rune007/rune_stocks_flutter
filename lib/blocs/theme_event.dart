import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

import '../models/stock_model.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class BullBearConditionChanged extends ThemeEvent {
  final BullBearCondition bullBearCondition;

  BullBearConditionChanged({@required this.bullBearCondition})
      : assert(bullBearCondition != null);

  @override
  List<Object> get props => [bullBearCondition];
}