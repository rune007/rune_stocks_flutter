import 'package:flutter/material.dart';
import 'dart:async';
import 'package:bloc/bloc.dart';

import '../models/stock_model.dart';
import './theme_state.dart';
import './theme_event.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  @override
  ThemeState get initialState => ThemeState(
        themeData: ThemeData.dark(),
        materialColor: Colors.blueGrey,
      );

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    if (event is BullBearConditionChanged) {
      yield _mapBullBearConditionToThemeData(event.bullBearCondition);
    }
  }

  ThemeState _mapBullBearConditionToThemeData(
      BullBearCondition bullBearCondition) {
    ThemeState themeState;
    switch (bullBearCondition) {
      case BullBearCondition.neutral:
        themeState = ThemeState(
            themeData: ThemeData(
              primaryColor: Colors.grey,
            ),
            materialColor: Colors.blueGrey);
        break;

      case BullBearCondition.bull:
        themeState = ThemeState(
            themeData: ThemeData(
              primaryColor: Colors.tealAccent,
            ),
            materialColor: Colors.teal);
        break;

      case BullBearCondition.bear:
        themeState = ThemeState(
            themeData: ThemeData(
              primaryColor: Colors.pinkAccent,
            ),
            materialColor: Colors.pink);
        break;
    }
    return themeState;
  }
}
