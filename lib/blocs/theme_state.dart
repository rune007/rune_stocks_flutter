import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class ThemeState extends Equatable {
  final ThemeData themeData;
  final MaterialColor materialColor;

  ThemeState({@required this.themeData, this.materialColor})
      : assert(themeData != null),
        assert(materialColor != null);

  @override
  List<Object> get props => [themeData, materialColor];
}
