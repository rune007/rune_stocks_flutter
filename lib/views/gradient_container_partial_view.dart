import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class GradientContainerPartialView extends StatelessWidget {
  final Widget widget;
  final MaterialColor materialColor;

  GradientContainerPartialView({
    Key key,
    @required this.widget,
    @required this.materialColor,
  })  : assert(materialColor != null, widget != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.4, 0.8, 1.0],
          colors: [
            materialColor[900],
            materialColor[500],
            materialColor[100],
          ],
        ),
      ),
      child: widget,
    );
  }
}
